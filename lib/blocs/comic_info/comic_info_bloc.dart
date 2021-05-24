import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import '../../repo/repo.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'comic_info_event.dart';
part 'comic_info_state.dart';

class ComicInfoBloc extends Bloc<ComicInfoEvent, ComicInfoState> {
  ComicInfoBloc() : super(ComicInfoInitial());
  final repo = GetData();
  @override
  Stream<ComicInfoState> mapEventToState(
    ComicInfoEvent event,
  ) async* {
    if (event is ComicInfoLoad) {
      try {
        yield ComicInfoLoading();

        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.wifi) {
          print("wifi");
          final docCharacters =
              await repo.updatecomicCharactersFirebase(event.id.toString());
          final docCreators =
              await repo.updatecomicCreatorsFirebase(event.id.toString());

          final docComic = await repo.updatecomicFirebase(event.id.toString());
          yield ComicInfoSuccess(
            comicInfo: docComic,
            comicCharacters: docCharacters,
            comicCreators: docCreators,
          );
        } else if (connectivityResult == ConnectivityResult.mobile) {
          print("mobile");

          final docCharacters =
              await repo.updatecomicCharactersFirebase(event.id.toString());
          final docCreators =
              await repo.updatecomicCreatorsFirebase(event.id.toString());
          print(event.id);
          final docComic = await repo.updatecomicFirebase(event.id.toString());
          yield ComicInfoSuccess(
            comicInfo: docComic,
            comicCharacters: docCharacters,
            comicCreators: docCreators,
          );
        } else if (connectivityResult == ConnectivityResult.none) {
          yield ComicInfoNetWorkError(uid: event.id);
        }
      } catch (e) {
        print(e.toString());
        yield ComicInfoError();
      }
    }
  }
}
