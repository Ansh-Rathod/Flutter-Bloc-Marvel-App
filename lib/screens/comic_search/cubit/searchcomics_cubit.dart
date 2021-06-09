import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
part 'searchcomics_state.dart';

class SearchcomicsCubit extends Cubit<SearchcomicsState> {
  SearchcomicsCubit() : super(SearchcomicsState.initial());

  void onSubmitted(String value) async {
    emit(state.copyWith(status: ComicStatus.loading));
    try {
      var comicCreaters = Uri.parse(
          'https://gateway.marvel.com/v1/public/comics?ts=1&apikey=690e3ac16286c2de4591eca37269eedb&hash=fcbd875beb64e407e41ea8088ed2cd0c&limit=100&titleStartsWith=$value');

      final response = await http.get(comicCreaters);
      final data = json.decode(response.body);
      final comics = data['data']['results'];
      if (comics.isEmpty) {
        emit(state.copyWith(
          status: ComicStatus.notFound,
        ));
      } else {
        emit(state.copyWith(status: ComicStatus.success, comics: comics));
      }
    } catch (e) {
      emit(state.copyWith(status: ComicStatus.error));
    }
  }
}
