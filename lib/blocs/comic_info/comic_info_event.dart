part of 'comic_info_bloc.dart';

@immutable
abstract class ComicInfoEvent {}

class ComicInfoLoad extends ComicInfoEvent {
  final int id;

  ComicInfoLoad(this.id);
}
