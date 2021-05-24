part of 'chara_info_bloc.dart';

@immutable
abstract class CharaInfoState {}

class CharaInfoInitial extends CharaInfoState {}

class CharaInfoLoading extends CharaInfoState {}

class CharaInfoSuccess extends CharaInfoState {
  final DocumentSnapshot<Map<String, dynamic>> snapshot;
  final DocumentSnapshot<Map<String, dynamic>> comics;
  CharaInfoSuccess({
    this.snapshot,
    this.comics,
  });
}

class CharaInfoNetWorkError extends CharaInfoState {
  final int id;

  CharaInfoNetWorkError({this.id});
}

class CharaInfoError extends CharaInfoState {}
