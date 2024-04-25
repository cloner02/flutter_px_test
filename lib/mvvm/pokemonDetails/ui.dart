import 'package:flutter/material.dart';
import 'package:flutter_pokedex/mvvm/loadingevent.dart';
import 'package:flutter_pokedex/mvvm/observer.dart';

import '../../components/appbar.dart';

class PokemonDetailsWidget extends StatefulWidget {
  const PokemonDetailsWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PokedexState();
  }
}

class _PokedexState extends State<PokemonDetailsWidget> implements EventObserver {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
        const Text('details')
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