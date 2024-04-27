import 'package:flutter/material.dart';
import 'package:flutter_pokedex/mvvm/loadingevent.dart';
import 'package:flutter_pokedex/mvvm/observer.dart';
import 'package:flutter_pokedex/mvvm/pokemon/model.dart';
import 'package:flutter_pokedex/mvvm/pokemon/repository.dart';
import 'package:flutter_pokedex/mvvm/pokemon/ui/components/pokemonbuttoncapture.dart';
import 'package:flutter_pokedex/mvvm/pokemon/ui/components/pokemondatarow.dart';
import 'package:flutter_pokedex/mvvm/pokemon/viewmodel/details_viewmodel.dart';
import 'package:flutter_pokedex/utils/capitalize.dart';

import '../../../components/appbar.dart';

class PokemonDetailsWidget extends StatefulWidget {
  final int id;
  final Widget? previousScreen;
  final Function(ThemeData) onThemeChanged;
  const PokemonDetailsWidget({Key? key, this.previousScreen, required this.onThemeChanged, required this.id}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        title: 'Details',
        previousScreen: widget.previousScreen,
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
                                  PokemonDataRow(label: 'Name:', value: '${_pokemon?.name.capitalize()}'), 
                                  PokemonDataRow(label: 'Weight:', value: '${_pokemon?.weight} hectograms'),
                                  PokemonDataRow(label: 'Height:', value: '${_pokemon?.height} decimetres'),
                                  PokemonDataRow(label: 'Type:', value: '${_pokemon?.typesString}'),
                                  PokemonButtonCapture(pokemon: _pokemon!,viewModel: _viewModel,isCatched: _isCatched),
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
        _viewModel.isCatched(pokemon: _pokemon!);
      });
    }
    else if (event is PokemonAddedEvent || event is PokemonRemovedEvent) {
      setState(() {
        _viewModel.isCatched(pokemon: _pokemon!);
        _viewModel.setNewTheme();
      });
    }
    else if (event is IsCatchedEvent)
    {
      setState(() {
        _isCatched = event.isCatched;
      });
    }
    else if (event is SetNewThemeEvent)
    {
      setState(() {
        widget.onThemeChanged(event.themeData);
      });
    }
  }
}