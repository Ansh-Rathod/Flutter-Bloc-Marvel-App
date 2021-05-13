part of 'searchcomics_cubit.dart';

enum ComicStatus { loading, success, error, initial, notFound }

class SearchcomicsState extends Equatable {
  final ComicStatus status;
  final String error;
  final List comics;
  SearchcomicsState({this.status, this.comics, this.error});

  factory SearchcomicsState.initial() {
    return SearchcomicsState(
      comics: [],
      status: ComicStatus.initial,
      error: '',
    );
  }
  @override
  List<Object> get props => [status, error, comics];
  @override
  bool get stringify => true;

  SearchcomicsState copyWith({
    ComicStatus status,
    String error,
    List comics,
  }) {
    return SearchcomicsState(
      status: status ?? this.status,
      error: error ?? this.error,
      comics: comics ?? this.comics,
    );
  }
}
