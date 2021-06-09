import 'dart:convert';
import '../models/listmodel.dart';

import '../models/characters_model.dart';
import 'package:http/http.dart' as http;

import '../models/data_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/failure.dart';

class GetData {
  Future<GetAllLists> getData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('HomeScreen')
          .doc('FullHomeScreen')
          .get();
      return GetAllLists.fromDocument(doc);
    } catch (e) {
      throw Failure(msg: e.message);
    }
  }

  Future<ListResponse> getLists(String searchText) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection('Characters')
          .where('searchIndex', arrayContains: searchText)
          .get();
      return ListResponse.fromDoc(data);
    } catch (e) {
      print(e.message);
    }
  }

  Future<DocumentSnapshot> updateFirebase(String id) async {
    var comicsUrl = Uri.parse(
        'https://gateway.marvel.com/v1/public/characters/${id.toString()}/comics?ts=1&apikey=690e3ac16286c2de4591eca37269eedb&hash=fcbd875beb64e407e41ea8088ed2cd0c');

    try {
      await FirebaseFirestore.instance
          .collection('Comics')
          .doc(id)
          .get()
          .then((value) async {
        if (!value.exists) {
          final response = await http.get(comicsUrl);
          final data = json.decode(response.body);
          value.reference.set({"comics": data['data']['results']});
        }
      });
      final doc =
          await FirebaseFirestore.instance.collection('Comics').doc(id).get();
      return doc;
    } catch (e) {
      print(e.message);
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> updatecomicFirebase(
      String id) async {
    var comicsUrl = Uri.parse(
        'https://gateway.marvel.com/v1/public/comics/$id?ts=1&apikey=690e3ac16286c2de4591eca37269eedb&hash=fcbd875beb64e407e41ea8088ed2cd0c');
    try {
      await FirebaseFirestore.instance
          .collection('ComicsById')
          .doc(id)
          .get()
          .then((value) async {
        if (!value.exists) {
          final response = await http.get(comicsUrl);
          final data = json.decode(response.body);
          value.reference.set(data['data']['results'][0]);
        }
      });
      final doc = await FirebaseFirestore.instance
          .collection('ComicsById')
          .doc(id)
          .get();
      return doc;
    } catch (e) {
      print(e.message);
    }
  }

  Future<DocumentSnapshot> updatecomicCreatorsFirebase(String id) async {
    var comicCreaters = Uri.parse(
        'https://gateway.marvel.com/v1/public/comics/$id/creators?ts=1&apikey=690e3ac16286c2de4591eca37269eedb&hash=fcbd875beb64e407e41ea8088ed2cd0c');
    try {
      await FirebaseFirestore.instance
          .collection('ComicCreators')
          .doc(id)
          .get()
          .then((value) async {
        if (!value.exists) {
          final response = await http.get(comicCreaters);
          final data = json.decode(response.body);
          value.reference.set({"Creators": data['data']['results']});
        }
      });
      final doc = await FirebaseFirestore.instance
          .collection('ComicCreators')
          .doc(id)
          .get();
      return doc;
    } catch (e) {
      print(e.message);
    }
  }

  Future<DocumentSnapshot> updatecomicCharactersFirebase(String id) async {
    var comicCreaters = Uri.parse(
        'https://gateway.marvel.com/v1/public/comics/$id/characters?ts=1&apikey=690e3ac16286c2de4591eca37269eedb&hash=fcbd875beb64e407e41ea8088ed2cd0c&limit=100');
    try {
      await FirebaseFirestore.instance
          .collection('ComicCharacters')
          .doc(id)
          .get()
          .then((value) async {
        if (!value.exists) {
          final response = await http.get(comicCreaters);
          final data = json.decode(response.body);
          value.reference.set({"characters": data['data']['results']});
        }
      });
      final doc = await FirebaseFirestore.instance
          .collection('ComicCharacters')
          .doc(id)
          .get();
      return doc;
    } catch (e) {
      print(e.message);
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> updateCreatorsFirebase(
      String id) async {
    var comicsUrl = Uri.parse(
        'https://gateway.marvel.com/v1/public/creators/$id?ts=1&apikey=690e3ac16286c2de4591eca37269eedb&hash=fcbd875beb64e407e41ea8088ed2cd0c');
    try {
      await FirebaseFirestore.instance
          .collection('CratorsById')
          .doc(id)
          .get()
          .then((value) async {
        if (!value.exists) {
          final response = await http.get(comicsUrl);
          final data = json.decode(response.body);
          value.reference.set(data['data']['results'][0]);
        }
      });
      final doc = await FirebaseFirestore.instance
          .collection('CratorsById')
          .doc(id)
          .get();
      return doc;
    } catch (e) {
      print(e.message);
    }
  }

  Future<DocumentSnapshot> updateCreatorscomicsFirebase(String id) async {
    var comicCreaters = Uri.parse(
        'https://gateway.marvel.com/v1/public/creators/$id/comics?ts=1&apikey=&hash=fcbd875beb64e407e41ea8088ed2cd0c&limit=100');
    try {
      await FirebaseFirestore.instance
          .collection('CreatorsComics')
          .doc(id)
          .get()
          .then((value) async {
        if (!value.exists) {
          final response = await http.get(comicCreaters);
          final data = json.decode(response.body);
          value.reference.set({"comics": data['data']['results']});
        }
      });
      final doc = await FirebaseFirestore.instance
          .collection('CreatorsComics')
          .doc(id)
          .get();
      return doc;
    } catch (e) {
      print(e.message);
    }
  }
}
