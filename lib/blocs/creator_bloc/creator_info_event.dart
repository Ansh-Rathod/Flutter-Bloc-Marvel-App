part of 'creator_info_bloc.dart';

@immutable
abstract class CreatorInfoEvent {}

class CreatorInfoLoad extends CreatorInfoEvent {
  final int id;

  CreatorInfoLoad(this.id);
}
