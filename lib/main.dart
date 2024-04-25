import 'package:flutter/material.dart';
import 'package:flutter_pokedex/mvvm/pokemonCollection/ui/collection_ui.dart';
import 'package:flutter_pokedex/mvvm/pokemonPokedex/ui.dart';

import 'components/appbar.dart';

void main() {
  runApp(const Pokedex());
}

class Pokedex extends StatelessWidget {
  const Pokedex({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex Code Challenge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: false,
        title: 'Pokédex Code Challenge',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(64),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 150),
                child: const  Text('Go to Pokédex', textAlign: TextAlign.center),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PokedexWidget()),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(64),
              ),
               child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 150),
                child: const  Text('Go to pokemons collected', textAlign: TextAlign.center),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CollectionWidget()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
