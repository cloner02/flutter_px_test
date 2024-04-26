import 'package:flutter/material.dart';
import 'package:flutter_pokedex/mvvm/pokemon/model.dart';


class PokemonBaseListView extends StatelessWidget {
  final List<Pokemon> pokemons;

  const PokemonBaseListView({
    Key? key,
    required this.pokemons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PokemonBaseListView(pokemons: pokemons);
  }

}
