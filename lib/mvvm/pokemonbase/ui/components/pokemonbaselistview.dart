import 'package:flutter/material.dart';
import 'package:flutter_pokedex/mvvm/pokemon/ui/details_ui.dart';
import 'package:flutter_pokedex/mvvm/pokemonbase/model.dart';


class PokemonBaseListView extends StatelessWidget {
  final List<PokemonBase> pokemons;
  final Widget? previousScreen;
  final Function(ThemeData) onThemeChanged;

  const PokemonBaseListView({
    Key? key,
    required this.pokemons,
    this.previousScreen,
    required this.onThemeChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(
              pokemons[index].name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokemonDetailsWidget(id: pokemons[index].id,onThemeChanged: onThemeChanged,  previousScreen: previousScreen),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
