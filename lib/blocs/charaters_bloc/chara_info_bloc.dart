import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import '../../models/failure.dart';
import '../../repo/repo.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'chara_info_event.dart';
part 'chara_info_state.dart';

class CharaInfoBloc extends Bloc<CharaInfoEvent, CharaInfoState> {
  CharaInfoBloc() : super(CharaInfoInitial());
  final repo = GetData();
  @override
  Stream<CharaInfoState> mapEventToState(
    CharaInfoEvent event,
  ) async* {
    if (event is CharaInfoLoad) {
      yield CharaInfoLoading();
      try {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.wifi) {
          final doc = await FirebaseFirestore.instance
              .collection('Characters')
              .doc(event.id.toString())
              .get();
          final comics = await repo.updateFirebase(event.id.toString());

          yield CharaInfoSuccess(snapshot: doc, comics: comics);
        } else if (connectivityResult == ConnectivityResult.mobile) {
          final doc = await FirebaseFirestore.instance
              .collection('Characters')
              .doc(event.id.toString())
              .get();
          final comics = await repo.updateFirebase(event.id.toString());

          yield CharaInfoSuccess(snapshot: doc, comics: comics);
        } else if (connectivityResult == ConnectivityResult.none) {
          yield CharaInfoNetWorkError(id: event.id);
        }
      } catch (e) {
        yield CharaInfoError();
      }
    }
  }
}
