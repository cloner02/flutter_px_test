import 'package:flutter/material.dart';
import 'package:flutter_pokedex/main.dart';
import 'package:flutter_pokedex/mvvm/loadingevent.dart';
import 'package:flutter_pokedex/mvvm/observer.dart';
import 'package:flutter_pokedex/mvvm/pokemon/model.dart';
import 'package:flutter_pokedex/mvvm/pokemon/repository.dart';
import 'package:flutter_pokedex/mvvm/pokemon/ui/components/pokemonlistview.dart';
import 'package:flutter_pokedex/mvvm/pokemon/viewmodel/collection_viewmodel.dart';

import '../../../components/appbar.dart';

class CollectionWidget extends StatefulWidget {
  final Widget? previousScreen;
  const CollectionWidget({this.previousScreen, super.key});

  @override
  State<StatefulWidget> createState() {
    return _CollectionState();
  }
}

class _CollectionState extends State<CollectionWidget> implements EventObserver {

  final PokemonCollectionViewModel _viewModel =
      PokemonCollectionViewModel(PokemonRepository());
  bool _isLoading = false;
  List<Pokemon> _pokemons = [];

  @override
  void initState() {
    super.initState();
    _viewModel.subscribe(this);
    _viewModel.loadPokemonCollection();
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
        title: 'Collection',
        previousScreen: Home(),
      ),
      body: _isLoading
            ? (const Center(
                child: CircularProgressIndicator(),
              ))
            : (Column(children: [
                const Expanded(
                    flex: 15,
                    child: Text('Filter')
                ),
                Expanded(
                    flex: 85,
                    child: PokemonListView(pokemons: _pokemons, previousScreen: const CollectionWidget()))
                ])
              )
      );
  }

  @override
  void notify(ViewEvent event) {
    if (event is LoadingEvent) {
      setState(() {
        _isLoading = event.isLoading;
      });
    }
    else if (event is CollectionLoadedEvent) {
      setState(() {
        _pokemons = event.pokemons;
      });
    }
  }

}