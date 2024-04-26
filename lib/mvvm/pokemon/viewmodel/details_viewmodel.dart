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

  void addPokemon({required Pokemon pokemon}) {
    _repository.addPokemon(pokemon).then((value) {
        notify(PokemonAddedEvent(pokemon: pokemon));
        notify(LoadingEvent(isLoading: false));
    });
  }

  void removePokemon({required Pokemon pokemon}) {
    _repository.removePokemon(pokemon).then((value) {
      notify(PokemonRemovedEvent(pokemon: pokemon));
      notify(LoadingEvent(isLoading: false));
    });
  }
  void isCatched({required Pokemon pokemon}) {
    _repository.isCatched(pokemon: pokemon).then((value) {
    notify(IsCatchedEvent(isCatched: value));
    notify(LoadingEvent(isLoading: false));
    });
  }
}

class PokemonLoadedEvent extends ViewEvent {
  final Pokemon pokemon;

  PokemonLoadedEvent({required this.pokemon}) : super("PokemonsLoadedEvent");
}

class PokemonAddedEvent extends ViewEvent {
  final Pokemon pokemon;

  PokemonAddedEvent({required this.pokemon}) : super("PokemonAddedEvent");
}

class PokemonRemovedEvent extends ViewEvent {
  final Pokemon pokemon;

  PokemonRemovedEvent({required this.pokemon}) : super("PokemonRemovedEvent");
}

class IsCatchedEvent extends ViewEvent {
  final bool isCatched;
  IsCatchedEvent({required this.isCatched}) : super("IsCatchedEvent");
}
