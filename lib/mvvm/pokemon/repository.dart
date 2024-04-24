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
    _pokemonList[_pokemonList.indexWhere((element) => element.id == pokemon.id)] = pokemon;
  }

  Future<List<Pokemon>> loadPokemons() async {
    // Simulate a http request
    final result = await ApiService().action(nameAction: "pokedex", data: {});
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_pokemonList);
  }
}