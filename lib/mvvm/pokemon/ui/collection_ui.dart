import 'package:flutter/material.dart';
import 'package:flutter_pokedex/main.dart';
import 'package:flutter_pokedex/mvvm/loadingevent.dart';
import 'package:flutter_pokedex/mvvm/observer.dart';
import 'package:flutter_pokedex/mvvm/pokemon/model.dart';
import 'package:flutter_pokedex/mvvm/pokemon/repository.dart';
import 'package:flutter_pokedex/mvvm/pokemon/ui/components/pokemonfilter.dart';
import 'package:flutter_pokedex/mvvm/pokemon/ui/components/pokemonlistview.dart';
import 'package:flutter_pokedex/mvvm/pokemon/viewmodel/collection_viewmodel.dart';

import '../../../components/appbar.dart';

class CollectionWidget extends StatefulWidget {
  final Widget? previousScreen;
  final Function(ThemeData) onThemeChanged;
  const CollectionWidget({this.previousScreen, required this.onThemeChanged, super.key});

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
  List<PokemonType> _pokemonTypes = [];

  @override
  void initState() {
    super.initState();
    _viewModel.subscribe(this);
    _viewModel.loadPokemonCollection();
    _viewModel.loadPokemonTypes();
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.unsubscribe(this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Collection',
        previousScreen: Home(onThemeChanged: widget.onThemeChanged),
      ),
      body: _isLoading
            ? (const Center(
                child: CircularProgressIndicator(),
              ))
            : (Column(children: [
                Expanded(
                    flex: 15,
                    child: PokemonFilter(pokemons: _pokemons, pokemonTypes: _pokemonTypes, viewModel: _viewModel)
                ),
                Expanded(
                    flex: 85,
                    child: PokemonListView(pokemons: _pokemons, previousScreen: CollectionWidget(onThemeChanged: widget.onThemeChanged), onThemeChanged: widget.onThemeChanged))
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
    else if (event is PokemonTypesLoadedEvent) {
      setState(() {
        _pokemonTypes = event.pokemontypes;
      });
    }
    else if (event is SortByNameLoadedEvent) {
      setState(() {
        _pokemons = event.pokemons;
      });
    }
    else if (event is FilterByTypeLoadedEvent) {
      setState(() {
        _pokemons = event.pokemons;
      });
    }
  }

}