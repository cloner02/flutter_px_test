class PokemonPokedex {
  int id;
  String name;
  PokemonPokedex({required this.id, required this.name});

  factory PokemonPokedex.fromJson(Map<String, dynamic> json) {
    return PokemonPokedex(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}