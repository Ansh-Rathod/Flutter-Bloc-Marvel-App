import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../blocs/charaters_bloc/chara_info_bloc.dart';
import '../chara_info.dart';
import 'dart:core';

import '../cubits/searchCubit/search_page_cubit.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageCubit, SearchPageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "Search characters e.g. Iron-man",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15))),
                  onChanged: (value) {
                    BlocProvider.of<SearchPageCubit>(context)
                        .textChanged(value);
                  },
                ),
              ),
            ),
          ),
          body: state.searchText != null
              ? StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Search')
                      .where('searchIndex', arrayContains: state.searchText)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapShot) {
                    if (snapShot.hasError) {
                      return Center(child: Text("Failed"));
                    } else if (!snapShot.hasData) {
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpinKitThreeBounce(
                              color: Colors.red,
                              size: 30.0,
                            ),
                            SizedBox(height: 20),
                            Text("Please wait till We fetch data..",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      );
                    }
                    return ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: snapShot.data.docs.map((document) {
                        return ListTile(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    BlocProvider<CharaInfoBloc>(
                                      create: (context) => CharaInfoBloc()
                                        ..add(
                                            CharaInfoLoad(id: document['id'])),
                                      child: CharaInfoScreen(),
                                    )));
                          },
                          title: Text(
                            document['name'],
                          ),
                        );
                      }).toList(),
                    );
                  },
                )
              : Container(
                  child: Center(
                    child: Text("Swipe Left to back."),
                  ),
                ),
        );
      },
    );
  }
}
