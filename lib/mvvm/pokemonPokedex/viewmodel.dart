import 'package:flutter_pokedex/mvvm/loadingevent.dart';
import 'package:flutter_pokedex/mvvm/pokemonPokedex/model.dart';

import '../viewmodel.dart';
import 'repository.dart';

import '/mvvm/observer.dart';


class PokemonPokedexViewModel extends EventViewModel {
  final PokemonPokedexRepository _repository;

  PokemonPokedexViewModel(this._repository);

  void loadPokedex({required String region}) {
    notify(LoadingEvent(isLoading: true));
    _repository.loadPokedexFromRegion(region: region).then((value) {
      notify(PokedexLoadedEvent(pokemons: value));
      notify(LoadingEvent(isLoading: false));
    });
  }

  void filterPokedex({String value = ""}) {
    notify(LoadingEvent(isLoading: true));
      List<PokemonPokedex> listPokemosFilter = _repository.filterPokedex(value: value);
      notify(FilterPokedexLoadedEvent(pokemons: listPokemosFilter));
      notify(LoadingEvent(isLoading: false));
  }


}

class PokedexLoadedEvent extends ViewEvent {
  final List<PokemonPokedex> pokemons;

  PokedexLoadedEvent({required this.pokemons}) : super("PokemonsLoadedEvent");
}

class FilterPokedexLoadedEvent extends ViewEvent {
  final List<PokemonPokedex> pokemons;

  FilterPokedexLoadedEvent({required this.pokemons}) : super("FilterPokemonsLoadedEvent");
}
