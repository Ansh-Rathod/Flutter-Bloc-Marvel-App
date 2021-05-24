import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import '../../models/data_class.dart';
import '../../models/failure.dart';
import '../../repo/repo.dart';
import 'package:meta/meta.dart';

part 'fetch_home_event.dart';
part 'fetch_home_state.dart';

class FetchHomeBloc extends Bloc<FetchHomeEvent, FetchHomeState> {
  FetchHomeBloc() : super(FectHomeInital());
  final repo = GetData();

  @override
  Stream<FetchHomeState> mapEventToState(
    FetchHomeEvent event,
  ) async* {
    if (event is FetchHomeEvent) {
      yield FetchHomeLoading();
      try {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.wifi) {
          final data = await repo.getData();
          yield FetchHomeSucess(
            characters: data.characters,
            spidermanComics: data.spidermanComics,
            ironmanComics: data.ironmanComics,
            avengersComics: data.avengersComics,
            captainAmericaComics: data.captainAmericaComics,
            xmenComics: data.xmenComics,
            femaleCharacters: data.femaleCharacters,
          );
        } else if (connectivityResult == ConnectivityResult.mobile) {
          final data = await repo.getData();
          yield FetchHomeSucess(
            characters: data.characters,
            spidermanComics: data.spidermanComics,
            ironmanComics: data.ironmanComics,
            avengersComics: data.avengersComics,
            captainAmericaComics: data.captainAmericaComics,
            xmenComics: data.xmenComics,
            femaleCharacters: data.femaleCharacters,
          );
        } else if (connectivityResult == ConnectivityResult.none) {
          yield FetchHomeNetWorkError();
        }
      } on Failure catch (e) {
        yield FetchHomeError(error: e);
      }
    }
  }
}
