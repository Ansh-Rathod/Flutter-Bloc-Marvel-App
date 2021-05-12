import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class GetAllLists {
  final List characters;
  final List spidermanComics;
  final List ironmanComics;
  final List avengersComics;
  final List captainAmericaComics;
  final List xmenComics;
  final List femaleCharacters;
  GetAllLists({
    this.characters,
    this.spidermanComics,
    this.ironmanComics,
    this.avengersComics,
    this.captainAmericaComics,
    this.xmenComics,
    this.femaleCharacters,
  });
  factory GetAllLists.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
  
    return GetAllLists(
      characters: doc.data()['PopularCheractors'],
      spidermanComics: doc.data()['SpiderComics'],
      ironmanComics: doc.data()['IronManComics'],
      avengersComics: doc.data()['AvengersComics'] ,
      captainAmericaComics: doc.data()['CaptainAmericaComics'],
      xmenComics: doc.data()['XmenComics'],
      femaleCharacters: doc.data()['FemaleCharacters'],
    );
  }
}
