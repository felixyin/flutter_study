import 'dart:async';
import '../models/film.dart';
import '../models/character.dart';
import '../models/planet.dart';

abstract class IStarWarsApi {
  Future<List<Film>> getFilms();
  Future<List<Character>> getCharacters();
  Future<List<Planet>> getPlanets();
}