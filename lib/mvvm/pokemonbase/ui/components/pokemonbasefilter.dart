import 'package:flutter/material.dart';
import 'package:flutter_pokedex/mvvm/pokemonbase/viewmodel/pokedex_viewmodel.dart';



class PokemonBaseFilter extends StatelessWidget {
  final PokemonPokedexViewModel viewModel;

  const PokemonBaseFilter({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                  margin: const EdgeInsets.all(10.0),
                  child: TextField(
                    onChanged: (value) {
                      viewModel.filterName(value: value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
  }

}
