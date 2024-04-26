import 'package:flutter_pokedex/mvvm/loadingevent.dart';

import '../../viewmodel.dart';
import '../repository.dart';

import '/mvvm/observer.dart';
import '../model.dart';

class PokemonDetailsViewModel extends EventViewModel {
  final PokemonRepository _repository;

  PokemonDetailsViewModel(this._repository);

  void loadPokemon({required int id}) {
    notify(LoadingEvent(isLoading: true));
    _repository.loadPokemon(id: id).then((value) {
      notify(PokemonLoadedEvent(pokemon: value));
      notify(LoadingEvent(isLoading: false));
    });
  }
}

class PokemonLoadedEvent extends ViewEvent {
  final Pokemon pokemon;

  PokemonLoadedEvent({required this.pokemon}) : super("PokemonsLoadedEvent");
}