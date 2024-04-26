import 'package:flutter_pokedex/api/api.dart';
import 'package:flutter_pokedex/utils/capitalize.dart';

import 'model.dart';

class PokemonPokedexRepository {
  final List<PokemonBase> _pokemonPokedexList = [];

  Future<List<PokemonBase>> loadPokedexFromRegion({required String region}) async {
    final response = await ApiService().action(
      actionName: "pokedex",
      parameters: {'region': region},
      data: {}
    );

    for (var pokemon in response['pokemon_entries']) {
      _pokemonPokedexList.add(PokemonBase.fromJson({
        "name": pokemon['pokemon_species']['name'].toString().capitalize(), 
        "id": pokemon['entry_number']
      }));
    }
    // sort by name
    _pokemonPokedexList.sort((a, b) => a.name.compareTo(b.name));

    return Future.value(_pokemonPokedexList);
  }
  
  List<PokemonBase> filterPokedex({required String value})  {
    return _pokemonPokedexList.where((pokemon) => pokemon.name.toLowerCase().contains(value.toLowerCase())).toList();
  }

}