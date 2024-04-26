import 'package:flutter/material.dart';
import 'package:flutter_pokedex/mvvm/pokemon/ui/collection_ui.dart';
import 'package:flutter_pokedex/mvvm/pokemonbase/ui/podekdex_ui.dart';
import 'components/appbar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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


  ElevatedButton buildElevatedButton({required BuildContext context, required Widget route, required String value}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(64),
    ),
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 150),
      child: Text(value, textAlign: TextAlign.center),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => route),
      );
    },
    );
  }

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
            buildElevatedButton(context: context, route: const PokedexWidget(), value: 'Go to Pokédex'),
            buildElevatedButton(context: context, route: const CollectionWidget(), value: 'Go to pokemons collected'),
          ],
        ),
      ),
    );
  }
}
