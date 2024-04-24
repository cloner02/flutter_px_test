import 'dart:ffi';

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


class Pokemon {
  int id;
  String name;
  Double height;
  Double weight;
  String photo;
  PokemonType type;
  Pokemon(this.id, this.name, this.height, this.weight, this.photo, this.type);

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      json['id'] as int,
      json['name'] as String,
      json['height'] as Double,
      json['weight'] as Double,
      json['photo'] as String,
      PokemonType.values[json['type'] as int], // assuming 'type' is stored as an integer
    );
  }
}