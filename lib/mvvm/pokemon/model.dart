import 'package:flutter_pokedex/mvvm/pokemonbase/model.dart';
import 'package:localstore/localstore.dart';

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

    Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      name: json['name'] ?? json['type']['name'] as String,
      url: json['url'] ?? json['type']['url'] as String,
    );
  }
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
      typeList.map((item) => PokemonType.fromJson(item)).toList();
    return Pokemon(
      id: pokemonPokedex.id,
      name: pokemonPokedex.name,
      height: json['height'] as int,
      weight: json['weight'] as int,
      photo:  json['photo'] ?? json['sprites']['front_default'] as String,
      types: pokemonTypeList,
    );
  }

  static Future<List<Pokemon>> getAll() async {
    final db = Localstore.instance;
    Future<Map<String, dynamic>?> pokemonListLocalStore = db.collection('pokemons').get();
    List<Pokemon> pokemonList = [];
    await pokemonListLocalStore.then((value) {
      if (value != null) {
        value.forEach((key, value) {
          pokemonList.add(Pokemon.fromJson(value));
        });
      }
    });

    return Future.value(pokemonList);
  }

  static Future<Pokemon?> getById(String id) async {
    final db = Localstore.instance;
    final pokemon = await db.collection('pokemons').doc(id).get();
    if (pokemon == null) {
      return null;
    }
    return Pokemon.fromJson(pokemon);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'weight': weight,
      'photo': photo,
      'types': types.map((e) => e.toMap()).toList(),
    };
  }

  String get typesString {
    return types.map((e) => e.name).join(", ");
  }

}

extension PokemonExtensions on Pokemon {
  Future save() async {
    final db = Localstore.instance;
    return db.collection('pokemons').doc(id.toString()).set(toMap());
  }

  Future delete() async {
    final db = Localstore.instance;
    return db.collection('pokemons').doc(id.toString()).delete();
  }
}