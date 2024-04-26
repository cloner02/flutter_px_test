import 'package:flutter_pokedex/mvvm/pokemonbase/model.dart';

abstract class Type {
  String get name;
  String get url;
}

class PokemonType implements Type {
  @override
  final String name;

  @override
  final String url;

  PokemonType({required this.name, required this.url});
}

class Pokemon extends PokemonBase{
  
  int height;
  int weight;
  String photo;
  final List<PokemonType> types;
  Pokemon({name = '', id = '', required this.height, required this.weight, this.photo = '',required this.types}) : super(id: id, name: name);

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    var pokemonPokedex = PokemonBase.fromJson(json);
    var typeList = json['types'] as List;
  List<PokemonType> pokemonTypeList =
      typeList.map((item) => PokemonType(name: item['type']['name'], url: item['type']['url'])).toList();
    return Pokemon(
      id: pokemonPokedex.id,
      name: pokemonPokedex.name,
      height: json['height'] as int,
      weight: json['weight'] as int,
      photo: json['sprites']['front_default'] as String,
      types: pokemonTypeList,
    );
  }

  String get typesString {
    return types.map((e) => e.name).join(", ");
  }
}