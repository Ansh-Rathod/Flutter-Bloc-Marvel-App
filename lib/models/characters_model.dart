import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetAllCharcters {
  final String id;
  final String name;
  final String description;
  final String thumbnail;
  final String resourceURI;
  GetAllCharcters({
    this.id,
    this.name,
    this.description,
    this.thumbnail,
    this.resourceURI,
  });
  factory GetAllCharcters.fromDocument(doc) {
    print(doc.data()['name']);
    return GetAllCharcters(
      id: doc.data()['id'].toString(),
      name: doc.data()['name'],
      description: doc.data()['description'],
      thumbnail:
          "${doc.data()['thumbnail']['path']}.${doc.data()['thumbnail']['extension']}",
      resourceURI: doc.data()['resourceURI'],
    );
  }
}
