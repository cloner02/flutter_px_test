import 'package:flutter_pokedex/mvvm/loadingevent.dart';

import '../../viewmodel.dart';
import '../repository.dart';

import '/mvvm/observer.dart';
import '../model.dart';

class PokemonCollectionViewModel extends EventViewModel {
  final PokemonRepository _repository;

  PokemonCollectionViewModel(this._repository);

  void loadPokemonCollection() {
    notify(LoadingEvent(isLoading: true));
    _repository.loadPokemonCollection().then((value) {
      notify(CollectionLoadedEvent(pokemons: value));
      notify(LoadingEvent(isLoading: false));
    });
  }

  void loadPokemonTypes() {
    notify(LoadingEvent(isLoading: true));
    _repository.loadPokemonTypes().then((value) {
      notify(PokemonTypesLoadedEvent(pokemontypes: value));
      notify(LoadingEvent(isLoading: false));
    });
  }

  void sortByName() {
    notify(LoadingEvent(isLoading: true));
      List<Pokemon> response = _repository.sortByName();
      notify(SortByNameLoadedEvent(pokemons: response));
      notify(LoadingEvent(isLoading: false));
  }

  void filterByType({required String type}) {
    notify(LoadingEvent(isLoading: true));
    List<Pokemon> response = _repository.filterByType(type: type);
    notify(FilterByTypeLoadedEvent(pokemons: response));
    notify(LoadingEvent(isLoading: false));
  }
  
}

class CollectionLoadedEvent extends ViewEvent {
  final List<Pokemon> pokemons;

  CollectionLoadedEvent({required this.pokemons}) : super("PokemonsLoadedEvent");
}

class PokemonTypesLoadedEvent extends ViewEvent {
  final List<PokemonType> pokemontypes;

  PokemonTypesLoadedEvent({required this.pokemontypes}) : super("PokemonTypesLoadedEvent");
}

class SortByNameLoadedEvent extends ViewEvent {
  final List<Pokemon> pokemons;

  SortByNameLoadedEvent({required this.pokemons}) : super("SortByNameLoadedEvent");
}

class FilterByTypeLoadedEvent extends ViewEvent {
  final List<Pokemon> pokemons;
  FilterByTypeLoadedEvent({required this.pokemons}) : super("FilterByTypeLoadedEvent");
}