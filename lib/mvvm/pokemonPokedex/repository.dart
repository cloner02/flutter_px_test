import 'package:flutter_pokedex/api/api.dart';

import 'model.dart';

class PokemonPokedexRepository {
  final List<PokemonPokedex> _pokemonPokedexList = [];

  Future<List<PokemonPokedex>> loadPokedexFromRegion({required String region}) async {
    final response = await ApiService().action(
      nameAction: "pokedex",
      parameters: {'region': region},
      data: {}
    );

    for (var pokemon in response['pokemon_entries']) {
      _pokemonPokedexList.add(PokemonPokedex.fromJson({
        "name": pokemon['pokemon_species']['name'], 
        "id": pokemon['entry_number']
      }));
    }
    
    return Future.value(_pokemonPokedexList);
  }
}