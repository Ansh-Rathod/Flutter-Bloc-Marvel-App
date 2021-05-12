import 'package:bloc/bloc.dart';
import '../../../models/listmodel.dart';
import '../../../repo/repo.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit() : super(SearchPageState());
  final repo = GetData();
  Future<void> textChanged(String text) async {
    emit(SearchPageState(searchText: text));
    print(state.searchText);
  }
}
