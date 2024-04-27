import 'package:flutter/material.dart';
import 'package:flutter_pokedex/mvvm/loadingevent.dart';
import 'package:flutter_pokedex/mvvm/pokemon/repository.dart';
import 'package:flutter_pokedex/mvvm/viewmodel.dart';

import '/mvvm/observer.dart';

class AppViewModel extends EventViewModel {
  final PokemonRepository _repository;

  AppViewModel(this._repository);

  void setNewTheme()
  {
    _repository.setNewTheme().then((value) {
      ThemeData themeData = value;
      notify(SetNewThemeEvent(themeData: themeData));
      notify(LoadingEvent(isLoading: false));
    });
  }
}

class SetNewThemeEvent extends ViewEvent {
  final ThemeData themeData;
  SetNewThemeEvent({required this.themeData}) : super("SetNewThemeEvent");
}
