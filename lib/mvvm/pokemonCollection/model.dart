import 'dart:ffi';

import 'package:flutter_pokedex/mvvm/pokemonPokedex/model.dart';

enum PokemonType {
  normal,
  fighting,
  flying,
  poison,
  ground,
  rock,
  bug,
  ghost,
  steel,
  fire,
  water,
  grass,
  electric,
  psychic,
  ice,
  dragon,
  dark,
  fairy,
  unknown,
  shadow,
}


class PokemonDetails extends PokemonPokedex{
  
  Double height;
  Double weight;
  String photo;
  PokemonType type;
  PokemonDetails({name = '', id = '', required this.height, required this.weight, this.photo = '',required this.type}) : super(id: id, name: name);

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    var pokemonPokedex = PokemonPokedex.fromJson(json);
    return PokemonDetails(
      id: pokemonPokedex.id,
      name: pokemonPokedex.name,
      height: json['height'] as Double,
      weight: json['weight'] as Double,
      photo: json['photo'] as String,
      type: PokemonType.values[json['type'] as int], // assuming 'type' is stored as an integer
    );
  }
}