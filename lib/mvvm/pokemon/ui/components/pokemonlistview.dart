import 'package:flutter/material.dart';
import 'package:flutter_pokedex/mvvm/pokemon/model.dart';
import 'package:flutter_pokedex/mvvm/pokemonbase/ui/components/pokemonbaselistview.dart';


class PokemonListView extends StatelessWidget {
  final List<Pokemon> pokemons;
  final Widget? previousScreen;
  final Function(ThemeData) onThemeChanged;

  const PokemonListView({
    Key? key,
    required this.pokemons,
    this.previousScreen,
    required this.onThemeChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PokemonBaseListView(pokemons: pokemons, previousScreen: previousScreen, onThemeChanged: onThemeChanged);
  }

}
