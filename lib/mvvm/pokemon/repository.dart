import 'package:flutter/material.dart';
import 'package:flutter_pokedex/api/api.dart';
import 'package:flutter_pokedex/utils/capitalize.dart';
import 'package:flutter_pokedex/utils/theme.dart';

import 'model.dart';

class PokemonRepository {
  List<Pokemon> _pokemonList = [];
  bool _isSortAsc = false;
  ThemeData _themeData =  ThemeData();

  Future<void> addPokemon(Pokemon pokemon) async {
    await pokemon.save();
  }
 
  Future<void> removePokemon(Pokemon pokemon) async{
    await pokemon.delete();
  }

  Future<Pokemon> loadPokemon({required int id}) async {
    dynamic response = {};
    response = await ApiService().action(
        actionName: 'pokemon', parameters: {'id': id.toString()});
    return Future.value(Pokemon.fromJson(response));
  }

  Future<List<PokemonType>> loadPokemonTypes() async {
    dynamic response = {};
    response = await ApiService().action(actionName: 'typelist');
    final List<PokemonType> pokemonTypes = [];
    for (final type in response['results']) {
      pokemonTypes.add(PokemonType.fromJson(type));
    }
    pokemonTypes.sort((a, b) => a.name.compareTo(b.name));
    return Future.value(pokemonTypes);
  }

  List<Pokemon> sortByName()  {
    _pokemonList.sort((a, b) => (_isSortAsc)? b.name.compareTo(a.name) : a.name.compareTo(b.name));
    _isSortAsc = !_isSortAsc;
    return _pokemonList;
  }

  Future<ThemeData> setNewTheme() async {
    Map<String, int> typeCounts = {};
    _pokemonList = await loadPokemonCollection();
    for (Pokemon pokemon in _pokemonList) {
      for (PokemonType type in pokemon.types) {
        if (typeCounts.containsKey(type.name)) {
          typeCounts[type.name] = typeCounts[type.name]! + 1;
        } else {
          typeCounts[type.name] = 1;
        }
      }
    }

    int highestCount = 0;
    List<String> mostCommonTypes = [];

    typeCounts.forEach((type, count) {
      if (count > highestCount) {
        highestCount = count;
        mostCommonTypes = [type];
      } else if (count == highestCount) {
        mostCommonTypes.add(type);
      }
    });

    String colorKey =  (mostCommonTypes.length == 1)? mostCommonTypes[0].capitalize() : 'default';


    _themeData = createTheme(colorKey: colorKey);
    return Future.value(_themeData);
  }

  Future<List<Pokemon>> loadPokemonCollection() async {
    _pokemonList.clear();
   
    _pokemonList = await Pokemon.getAll();
    _pokemonList.sort((a, b) => a.id.compareTo(b.id));
    
    return Future.value(_pokemonList);
  }

  Future<bool> isCatched({required Pokemon pokemon}) async {
    final bool isCatched = await Pokemon.getById(pokemon.id.toString()) != null;

    return Future.value(isCatched);
  }

  List<Pokemon> filterByType({required String type})  {
    return _pokemonList.where((pokemon) {
      final List<PokemonType> types = pokemon.types;
      return type == 'All Types' || types.any((element) => element.name.toLowerCase().contains(type.toLowerCase())) ||
          pokemon.name.toLowerCase().contains(type.toLowerCase());
    }).toList();
  }
}
