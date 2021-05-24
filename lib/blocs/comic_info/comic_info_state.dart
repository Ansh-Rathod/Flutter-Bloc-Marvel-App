part of 'comic_info_bloc.dart';

@immutable
abstract class ComicInfoState {}

class ComicInfoInitial extends ComicInfoState {}

class ComicInfoLoading extends ComicInfoState {}

class ComicInfoSuccess extends ComicInfoState {
  final DocumentSnapshot<Map<String, dynamic>> comicInfo;
  final DocumentSnapshot<Map<String, dynamic>> comicCharacters;
  final DocumentSnapshot<Map<String, dynamic>> comicCreators;
  ComicInfoSuccess({
    this.comicInfo,
    this.comicCharacters,
    this.comicCreators,
  });
}

class ComicInfoNetWorkError extends ComicInfoState {
  final int uid;
  ComicInfoNetWorkError({
    this.uid,
  });
}

class ComicInfoError extends ComicInfoState {}
