class PokemonBase {
  int id;
  String name;
  PokemonBase({required this.id, required this.name});

  factory PokemonBase.fromJson(Map<String, dynamic> json) {
    return PokemonBase(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}