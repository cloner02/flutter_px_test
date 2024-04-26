import 'package:flutter_pokedex/api/api.dart';

import 'model.dart';

class PokemonRepository {
  List<Pokemon> _pokemonList = [];

  void addPokemon(Pokemon pokemon) {
    pokemon.save();
  }

  void removePokemon(Pokemon pokemon) {
    pokemon.delete();
  }

  Future<Pokemon> loadPokemon({required int id}) async {
    dynamic response = {};
    response = await ApiService().action(
        actionName: 'pokemon', parameters: {'id': id.toString()});
    return Future.value(Pokemon.fromJson(response));
  }

  Future<List<Pokemon>> loadPokemonCollection(
    {required String region}) async {

    Pokemon.getAll().then((value) {
        _pokemonList.clear();
        _pokemonList = value;
    });

    return Future.value(_pokemonList);
  }

  Future<bool> isCatched({required Pokemon pokemon}) async {
    final bool isCatched = await Pokemon.getById(pokemon.id.toString()) != null;

    return Future.value(isCatched);
  }
}
