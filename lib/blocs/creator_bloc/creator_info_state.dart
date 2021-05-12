part of 'creator_info_bloc.dart';

@immutable
abstract class CreatorInfoState {}

class CreatorInfoInitial extends CreatorInfoState {}

class CreatorInfoLoading extends CreatorInfoState {}

class CreatorInfoSuccess extends CreatorInfoState {
  final DocumentSnapshot<Map<String, dynamic>> creatorInfo;
  final DocumentSnapshot<Map<String, dynamic>> creatorComics;
  CreatorInfoSuccess({
    this.creatorInfo,
    this.creatorComics,
  });
}

class CreatorInfoError extends CreatorInfoState {}
