import 'package:flutter_pokedex/mvvm/observer.dart';

class LoadingEvent extends ViewEvent {
  bool isLoading;

  LoadingEvent({required this.isLoading}) : super("LoadingEvent");
}