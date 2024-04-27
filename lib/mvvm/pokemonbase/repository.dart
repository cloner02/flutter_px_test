import 'package:flutter_pokedex/api/api.dart';
import 'package:flutter_pokedex/utils/capitalize.dart';

import 'model.dart';

class PokemonBaseRepository {
  final List<PokemonBase> _pokemonList = [];

  Future<List<PokemonBase>> loadPokedexFromRegion({required String region}) async {
    final response = await ApiService().action(
      actionName: "pokedex",
      parameters: {'region': region},
      data: {}
    );

    for (var pokemon in response['pokemon_entries']) {
      _pokemonList.add(PokemonBase.fromJson({
        "name": pokemon['pokemon_species']['name'].toString().capitalize(), 
        "id": pokemon['entry_number']
      }));
    }

    _pokemonList.sort((a, b) => a.name.compareTo(b.name));

    return Future.value(_pokemonList);
  }
  
  List<PokemonBase> filterName({required String value})  {
    return _pokemonList.where((pokemon) => pokemon.name.toLowerCase().contains(value.toLowerCase())).toList();
  }

}