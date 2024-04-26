import 'package:flutter_pokedex/api/api.dart';

import 'model.dart';

class PokemonRepository {
  final List<Pokemon> _pokemonList = [];

  void addPokemon(Pokemon pokemon) {
    _pokemonList.add(pokemon);
  }

  void removePokemon(Pokemon pokemon) {
    _pokemonList.remove(pokemon);
  }

  void updatePokemon(Pokemon pokemon) {
    _pokemonList[_pokemonList
        .indexWhere((element) => element.id == pokemon.id)] = pokemon;
  }

  Future<Pokemon> loadPokemon({required int id}) async {
    dynamic response = {};
    response = await ApiService().action(
        actionName: 'pokemon', parameters: {'id': id.toString()});
    return Future.value(Pokemon.fromJson(response));
  }

  Future<List<Pokemon>> loadPokemonCollection(
    {required String region}) async {
    dynamic response = [];

    for (var pokemon in response) {
      _pokemonList.add(Pokemon.fromJson({
        "name": pokemon['pokemon_species']['name'],
        "id": pokemon['entry_number']
      }));
    }

    return Future.value(_pokemonList);
  }
}
