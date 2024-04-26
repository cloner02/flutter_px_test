import 'package:flutter_pokedex/mvvm/loadingevent.dart';

import '../../viewmodel.dart';
import '../repository.dart';

import '/mvvm/observer.dart';
import '../model.dart';

class PokemonCollectionViewModel extends EventViewModel {
  final PokemonRepository _repository;

  PokemonCollectionViewModel(this._repository);

  void loadPokemonCollection({required String region}) {
    notify(LoadingEvent(isLoading: true));
    _repository.loadPokemonCollection(region: region).then((value) {
      notify(CollectionLoadedEvent(pokemons: value));
      notify(LoadingEvent(isLoading: false));
    });
  }
}

class CollectionLoadedEvent extends ViewEvent {
  final List<Pokemon> pokemons;

  CollectionLoadedEvent({required this.pokemons}) : super("PokemonsLoadedEvent");
}