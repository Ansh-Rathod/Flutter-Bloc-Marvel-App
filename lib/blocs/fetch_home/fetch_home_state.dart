part of 'fetch_home_bloc.dart';

@immutable
abstract class FetchHomeState {}

class FectHomeInital extends FetchHomeState {}

class FetchHomeSucess extends FetchHomeState {
  final List characters;
  final List spidermanComics;
  final List ironmanComics;
  final List avengersComics;
  final List captainAmericaComics;
  final List xmenComics;
  final List femaleCharacters;
  FetchHomeSucess({
    this.characters,
    this.spidermanComics,
    this.ironmanComics,
    this.avengersComics,
    this.captainAmericaComics,
    this.xmenComics,
    this.femaleCharacters,
  });
}

class FetchHomeError extends FetchHomeState {
  final Failure error;
  FetchHomeError({
    this.error,
  });
}

class FetchHomeLoading extends FetchHomeState {}

class FetchHomeNetWorkError extends FetchHomeState {}
