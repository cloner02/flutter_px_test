import 'package:flutter/material.dart';
import 'package:flutter_pokedex/mvvm/pokemon/ui/collection_ui.dart';
import 'package:flutter_pokedex/mvvm/pokemon/ui/pokedex_ui.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Go to Pokédex'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PokedexWidget()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Go to Collector'),
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
