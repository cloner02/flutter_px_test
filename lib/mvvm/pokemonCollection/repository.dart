import 'model.dart';

class PokemonRepository {
  final List<PokemonDetails> _pokemonList = [];

  void addPokemon(PokemonDetails pokemon) {
    _pokemonList.add(pokemon);
  }

  void removePokemon(PokemonDetails pokemon) {
    _pokemonList.remove(pokemon);
  }

  void updatePokemon(PokemonDetails pokemon) {
    _pokemonList[_pokemonList.indexWhere((element) => element.id == pokemon.id)] = pokemon;
  }

  Future<List<PokemonDetails>> loadPokemonCollection({required String region}) async {
    dynamic response = [];

    for (var pokemon in response) {
      _pokemonList.add(PokemonDetails.fromJson({
        "name": pokemon['pokemon_species']['name'], 
        "id": pokemon['entry_number']
      }));
    }
    
    return Future.value(_pokemonList);
  }
}