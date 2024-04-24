import 'package:flutter/material.dart';

import '../../../components/appbar.dart';

class PokedexWidget extends StatefulWidget {
  const PokedexWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PokedexState();
  }
}

class _PokedexState extends State<PokedexWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Pokedex',
      ),
      body: Center(
        child: Text('Pokedex'),
      )
    );
  }
}