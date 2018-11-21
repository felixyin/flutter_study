import 'dart:async';
import 'package:meta/meta.dart';
import '../interfaces/i_star_wars_api.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/film.dart';
import '../models/character.dart';
import '../models/planet.dart';

class MainPageViewModel extends Model {
  Future<List<Film>> _films;
  Future<List<Film>> get films => _films;
  set films(Future<List<Film>> value) {
    _films = value;
    notifyListeners();
  }

  Future<List<Character>> _characters;
  Future<List<Character>> get characters => _characters;
  set characters(Future<List<Character>> value) {
    _characters = value;
    notifyListeners();
  }

  Future<List<Planet>> _planets;
  Future<List<Planet>> get planets => _planets;
  set planets(Future<List<Planet>> value) {
    _planets = value;
    notifyListeners();
  }

  final IStarWarsApi api;

  MainPageViewModel({@required this.api});

  Future<bool> setFilms() async {
    films = api?.getFilms();
    return films != null;
  }

  Future<bool> setCharacters() async {
    characters = api?.getCharacters();
    return characters != null;
  }

  Future<bool> setPlanets() async {
    planets = api?.getPlanets();
    return planets != null;
  }
}