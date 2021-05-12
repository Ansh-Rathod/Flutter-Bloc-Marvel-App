import 'package:flutter/material.dart';

class ListModel {
  final String name;

  ListModel(this.name);
}

class ListResponse {
  final List list;
  ListResponse({
    @required this.list,
  });

  factory ListResponse.fromDoc(doc) {
    final docs =
        doc.docs.map((data) => ListModel(data.data()['name'])).toList();
    return ListResponse(list: docs);
  }
}
