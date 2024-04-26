import 'package:flutter/material.dart';
import 'package:flutter_pokedex/mvvm/pokemon/model.dart';
import 'package:flutter_pokedex/mvvm/pokemon/viewmodel/collection_viewmodel.dart';
import 'package:flutter_pokedex/utils/capitalize.dart';


class PokemonFilter extends StatelessWidget {
  final List<Pokemon> pokemons;
  final List<PokemonType> pokemonTypes;
  final PokemonCollectionViewModel viewModel;

  const PokemonFilter({
    Key? key,
    required this.pokemons,
    required this.pokemonTypes,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        DropdownButton<String>(
          hint: const Text('Select Pokemon Type'),
          items: <DropdownMenuItem<String>>[
          const DropdownMenuItem<String>(
            alignment: Alignment.center,
            value: '',
            child: Text('All Types'),
          ),
          ...pokemonTypes.map((PokemonType type) {
            return DropdownMenuItem<String>(
              alignment: Alignment.center,
              value: type.name,
              child: Text(type.name.capitalize()),
            );
          }).toList(),
        ],
          onChanged: (value) {
            if (value != null)
            {
              viewModel.filterByType(type: value);
            }
          },
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.sort_by_alpha), 
          label: const Text('Sort by Name'),
          onPressed: () {
            // Sort _pokemons by name
            viewModel.sortByName();
          },
        ),
      ],
    );
  }

}
