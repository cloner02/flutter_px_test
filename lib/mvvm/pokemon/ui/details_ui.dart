import 'package:flutter/material.dart';
import 'package:flutter_pokedex/mvvm/loadingevent.dart';
import 'package:flutter_pokedex/mvvm/observer.dart';
import 'package:flutter_pokedex/mvvm/pokemon/model.dart';
import 'package:flutter_pokedex/mvvm/pokemon/repository.dart';
import 'package:flutter_pokedex/mvvm/pokemon/viewmodel/details_viewmodel.dart';

import '../../../components/appbar.dart';

class PokemonDetailsWidget extends StatefulWidget {
  final int id;
  const PokemonDetailsWidget({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PokedexState();
  }
}

class _PokedexState extends State<PokemonDetailsWidget> implements EventObserver {
  final PokemonDetailsViewModel _viewModel =
      PokemonDetailsViewModel(PokemonRepository());
  bool _isLoading = false;
  Pokemon? _pokemon;

  @override
  void initState() {
    super.initState();
    _viewModel.subscribe(this);
    _viewModel.loadPokemon(id: widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.unsubscribe(this);
  }

  Row buildRow({required String label, String? value, Widget? widget}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        (value) != null? Text(value) : widget ?? Container(),
      ],
    );
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
        Column(
          children: [ Expanded(
                        flex: 35,
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          child: Image.network(_pokemon?.photo ?? '', fit: BoxFit.cover)
                        )
                      ),
                      Expanded(
                        flex: 65,
                        child:
                        Container(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child:    ListView(
                          children: <Widget>[
                            buildRow(label: 'Name', value: '${_pokemon?.name}'), 
                            buildRow(label: 'Weight', value: '${_pokemon?.weight} hectograms'),
                            buildRow(label: 'Height', value: '${_pokemon?.height} decimetres'),
                            buildRow(label: 'Type', value: '${_pokemon?.typesString}'),
                          ],
                        )
                        )
                      )
          ]
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
    }
    else if (event is PokemonLoadedEvent) {
      setState(() {
        _pokemon = event.pokemon;
      });
    }
  }
}