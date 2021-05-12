part of 'chara_info_bloc.dart';

@immutable
abstract class CharaInfoEvent {}

class CharaInfoLoad extends CharaInfoEvent {
  final int id;

  CharaInfoLoad({this.id});
}
