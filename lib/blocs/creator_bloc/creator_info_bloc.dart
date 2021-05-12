import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:marvelapp/repo/repo.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'creator_info_event.dart';
part 'creator_info_state.dart';

class CreatorInfoBloc extends Bloc<CreatorInfoEvent, CreatorInfoState> {
  CreatorInfoBloc() : super(CreatorInfoInitial());
  final repo = GetData();
  @override
  Stream<CreatorInfoState> mapEventToState(
    CreatorInfoEvent event,
  ) async* {
    if (event is CreatorInfoLoad) {
      try {
        yield CreatorInfoLoading();
        final docCreatorInfo =
            await repo.updateCreatorsFirebase(event.id.toString());
        final docCreatorComics =
            await repo.updateCreatorscomicsFirebase(event.id.toString());

        yield CreatorInfoSuccess(
          creatorComics: docCreatorComics,
          creatorInfo: docCreatorInfo,
        );
      } catch (e) {
        yield CreatorInfoError();
      }
    }
  }
}
