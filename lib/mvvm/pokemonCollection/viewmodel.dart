import 'package:flutter_pokedex/mvvm/loadingevent.dart';

import '../viewmodel.dart';
import 'repository.dart';

import '/mvvm/observer.dart';
import 'model.dart';

class PokemonViewModel extends EventViewModel {
  final PokemonRepository _repository;

  PokemonViewModel(this._repository);

  void loadPokemonCollection({required String region}) {
    notify(LoadingEvent(isLoading: true));
    _repository.loadPokemonCollection(region: region).then((value) {
      notify(CollectionLoadedEvent(pokemons: value));
      notify(LoadingEvent(isLoading: false));
    });
  }
}

class CollectionLoadedEvent extends ViewEvent {
  final List<PokemonDetails> pokemons;

  CollectionLoadedEvent({required this.pokemons}) : super("PokemonsLoadedEvent");
}

// should be emitted when 
class PokemonCreatedEvent extends ViewEvent {
  final PokemonDetails pokemon;

  PokemonCreatedEvent(this.pokemon) : super("PokemonCreatedEvent");
}