import 'package:flutter/material.dart';
import 'package:flutter_pokedex/mvvm/pokemon/model.dart';
import 'package:flutter_pokedex/mvvm/pokemon/viewmodel/details_viewmodel.dart';


class PokemonButtonCapture extends StatelessWidget {
  final PokemonDetailsViewModel viewModel;
  final Pokemon pokemon;
  final bool isCatched;

  const PokemonButtonCapture({
    Key? key,
    required this.viewModel,
    required this.pokemon,
    required this.isCatched
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
              IconButton(
                icon: Icon(
                  Icons.catching_pokemon_outlined,
                  size: 100,
                  color: isCatched? Colors.green : Colors.red,
                ),
                onPressed: () {
                    isCatched? viewModel.removePokemon(pokemon:pokemon): viewModel.addPokemon(pokemon:pokemon);
                },
              ),
              isCatched? const Text('Release Pokemon', style: TextStyle(fontSize: 20) ) : const Text('Catch Pokemon', style: TextStyle(fontSize: 20)), // add your text here
            ],
          );
  }

}