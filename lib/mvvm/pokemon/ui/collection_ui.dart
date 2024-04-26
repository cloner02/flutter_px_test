import 'package:flutter/material.dart';
import 'package:flutter_pokedex/mvvm/loadingevent.dart';
import 'package:flutter_pokedex/mvvm/observer.dart';
import 'package:flutter_pokedex/mvvm/pokemon/model.dart';
import 'package:flutter_pokedex/mvvm/pokemon/repository.dart';
import 'package:flutter_pokedex/mvvm/pokemon/viewmodel/collection_viewmodel.dart';

import '../../../components/appbar.dart';

class CollectionWidget extends StatefulWidget {
  const CollectionWidget({super.key});

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
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Collection',
      ),
      body: Center(
        child: CircularProgressIndicator(),
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
  }

}