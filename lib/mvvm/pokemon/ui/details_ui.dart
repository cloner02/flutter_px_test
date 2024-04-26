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
    //_viewModel.isCatched(pokemon: _pokemon!);
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.unsubscribe(this);
  }

  Column catchPokemonButton()
  {
    return 
        Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.catching_pokemon_outlined,
                      size: 100,
                      color: _isCatched? Colors.green : Colors.red,
                    ),
                    onPressed: () {
                       _isCatched? _viewModel.removePokemon(pokemon:_pokemon!): _viewModel.addPokemon(pokemon:_pokemon!);
                    },
                  ),
                  _isCatched? const Text('Release Pokemon') : const Text('Catch Pokemon'), // add your text here
                ],
              );
  }

  Padding pokemonDataRow({required String label, required String value}) {
    return 
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white // set the border radius
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Expanded(
            child: Text(label, textAlign: TextAlign.end, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
          ),
          Expanded(
            child: Padding(
            padding: const EdgeInsets.only(left: 8.0), // Add left padding here
            child: Text(value, textAlign: TextAlign.start, style: const TextStyle(fontSize: 20)),
            ),
          ),
          ],
              )
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
                        child: 
                              Container(
                                color: Theme.of(context).colorScheme.primaryContainer,
                                child:    ListView(
                                children: <Widget>[
                                  pokemonDataRow(label: 'Name:', value: '${_pokemon?.name.capitalize()}'), 
                                  pokemonDataRow(label: 'Weight:', value: '${_pokemon?.weight} hectograms'),
                                  pokemonDataRow(label: 'Height:', value: '${_pokemon?.height} decimetres'),
                                  pokemonDataRow(label: 'Type:', value: '${_pokemon?.typesString}'),
                                  catchPokemonButton(),
                                ],
                              )
                            )
                    ),
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
    else if (event is PokemonAddedEvent || event is PokemonRemovedEvent) {
      setState(() {
        _viewModel.isCatched(pokemon: _pokemon!);
      });
    }
    else if (event is IsCatchedEvent)
    {
      setState(() {
        _isCatched = event.isCatched;
      });
    }
  }
}