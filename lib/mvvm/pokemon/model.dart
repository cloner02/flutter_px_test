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
  Float height;
  Float weight;
  String photo;
  PokemonType type;
  Pokemon(this.id, this.name, this.height, this.weight, this.photo, this.type);
}