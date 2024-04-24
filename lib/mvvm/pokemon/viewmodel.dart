import '../viewmodel.dart';
import 'repository.dart';

import '/mvvm/observer.dart';
import 'model.dart';

class PokemonViewModel extends EventViewModel {
  final PokemonRepository _repository;

  PokemonViewModel(this._repository);

  void loadPokemons() {
    notify(LoadingEvent(isLoading: true));
    _repository.loadPokemons().then((value) {
      notify(PokemonsLoadedEvent(pokemons: value));
      notify(LoadingEvent(isLoading: false));
    });
  }

  void addPokemon(Pokemon pokemon) {
     notify(LoadingEvent(isLoading: true));
      _repository.addPokemon(pokemon);
     notify(PokemonCreatedEvent(pokemon));
     notify(LoadingEvent(isLoading: false));
  }
}

class LoadingEvent extends ViewEvent {
  bool isLoading;

  LoadingEvent({required this.isLoading}) : super("LoadingEvent");
}

class PokemonsLoadedEvent extends ViewEvent {
  final List<Pokemon> pokemons;

  PokemonsLoadedEvent({required this.pokemons}) : super("PokemonsLoadedEvent");
}

// should be emitted when 
class PokemonCreatedEvent extends ViewEvent {
  final Pokemon pokemon;

  PokemonCreatedEvent(this.pokemon) : super("PokemonCreatedEvent");
}