import 'package:flutter/material.dart';
import 'package:flutter_pokedex/mvvm/loadingevent.dart';
import 'package:flutter_pokedex/mvvm/observer.dart';
import 'package:flutter_pokedex/mvvm/pokemon/model.dart';
import 'package:flutter_pokedex/mvvm/pokemon/repository.dart';
import 'package:flutter_pokedex/mvvm/pokemon/viewmodel/details_viewmodel.dart';
import 'package:flutter_pokedex/utils/capitalize.dart';

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
  bool _isCatched = false;

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

  Padding buildRow({required String label, String? value, Widget? widget}) {
    return 
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white // set the border radius
        ),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Expanded(
          child: Text(label, textAlign: TextAlign.start, style: const TextStyle(fontSize: 20)),
        ),
        Expanded(
          child: (value) != null ? Text(value, textAlign: TextAlign.start, style: const TextStyle(fontSize: 20) ) : widget ?? Container(),
        ),
        ],
      ),
      )
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
                        child: Stack(
                          children: [
                                     Container(
                                        color: Theme.of(context).colorScheme.primaryContainer,
                                        child:    ListView(
                                        children: <Widget>[
                                          buildRow(label: 'Name', value: '${_pokemon?.name.capitalize()}'), 
                                          buildRow(label: 'Weight', value: '${_pokemon?.weight} hectograms'),
                                          buildRow(label: 'Height', value: '${_pokemon?.height} decimetres'),
                                          buildRow(label: 'Type', value: '${_pokemon?.typesString}'),
                                        ],
                                      )
                                    ),
                                    Positioned(
                                      bottom: 150,
                                      right: 50,
                                      left: 50,
                                      child: Column(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.catching_pokemon_outlined,
                                              size: 100,
                                              color: _isCatched? Colors.green : Colors.red,
                                            ),
                                            onPressed: () {
                                               _viewModel.addPokemon(pokemon:_pokemon!);
                                            },
                                          ),
                                          _isCatched? const Text('Release Pokemon') : const Text('Catch Pokemon'), // add your text here
                                        ],
                                      ),
                                    )
                                  ]
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
    else if (event is PokemonAddedEvent) {
      setState(() {
        _isCatched = true;
      });
    }
  }
}