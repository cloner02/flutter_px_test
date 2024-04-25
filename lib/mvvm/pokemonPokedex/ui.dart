import 'package:flutter/material.dart';
import 'package:flutter_pokedex/mvvm/loadingevent.dart';
import 'package:flutter_pokedex/mvvm/observer.dart';
import 'package:flutter_pokedex/mvvm/pokemonDetails/ui.dart';
import 'package:flutter_pokedex/mvvm/pokemonPokedex/model.dart';
import 'package:flutter_pokedex/mvvm/pokemonPokedex/repository.dart';
import 'package:flutter_pokedex/mvvm/pokemonPokedex/viewmodel.dart';

import '../../components/appbar.dart';

class PokedexWidget extends StatefulWidget {
  const PokedexWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PokedexState();
  }
}

class _PokedexState extends State<PokedexWidget> implements EventObserver {
  final PokemonPokedexViewModel _viewModel = PokemonPokedexViewModel(PokemonPokedexRepository());
  bool _isLoading = false;
  List<PokemonPokedex> _pokemons = [];

  @override
  void initState() {
    super.initState();
    _viewModel.subscribe(this);
    _viewModel.loadPokedex(region: 'kanto');
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Pokedex',
      ),
      body: _isLoading ? (
        const Center(
          child: CircularProgressIndicator(),
        )
      ) : ( 
        ListView.builder(
              itemCount: _pokemons.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      _pokemons[index].name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PokemonDetailsWidget(),
                        ),
                      );
                    },
                  ),
                );
              },
        )
      )
    );
  }

  @override
  void notify(ViewEvent event) {
    if (event is LoadingEvent) {
      setState(() {
        _isLoading = event.isLoading;
      });
    } else if (event is PokedexLoadedEvent) {
      setState(() {
        _pokemons = event.pokemons;
      });
    }
  }
}