import 'package:flutter/material.dart';
import 'package:flutter_pokedex/mvvm/observer.dart';
import 'package:flutter_pokedex/mvvm/pokemon/repository.dart';
import 'package:flutter_pokedex/mvvm/pokemon/ui/collection_ui.dart';
import 'package:flutter_pokedex/mvvm/pokemon/viewmodel/details_viewmodel.dart';
import 'package:flutter_pokedex/mvvm/pokemonbase/ui/podekdex_ui.dart';
import 'package:flutter_pokedex/utils/theme.dart';
import 'components/appbar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Pokedex());
}

class Pokedex extends StatefulWidget {
  const Pokedex({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PokedexState();
  }
}

class _PokedexState extends State<Pokedex> {
  ThemeData _themeData = ThemeData();

  @override
  void initState() {
    super.initState();
    _themeData =  createTheme();
  }

  void _changeTheme(ThemeData newTheme) {
    setState(() {
      _themeData = newTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex Code Challenge',
      theme: _themeData,
      home: Home(onThemeChanged: _changeTheme),
    );
  }
}

class Home extends StatefulWidget {
  final Function(ThemeData) onThemeChanged;
  const Home({super.key , required this.onThemeChanged});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> implements EventObserver{
  final PokemonDetailsViewModel _viewModel =
      PokemonDetailsViewModel(PokemonRepository());
  
  @override
  void initState() {
    super.initState();
    _viewModel.setNewTheme();
    _viewModel.subscribe(this);
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.unsubscribe(this);
  }


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
            buildElevatedButton(context: context, route: PokedexWidget(onThemeChanged: widget.onThemeChanged), value: 'Go to Pokédex'),
            buildElevatedButton(context: context, route: CollectionWidget(onThemeChanged: widget.onThemeChanged), value: 'Go to pokemons collected'),
          ],
        ),
      ),
    );
  }

  @override
  void notify(ViewEvent event) {
    if (event is SetNewThemeEvent)
    {
      setState(() {
        widget.onThemeChanged(event.themeData);
      });
    }
  }
}
