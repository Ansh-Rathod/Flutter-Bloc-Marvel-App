import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../blocs/charaters_bloc/chara_info_bloc.dart';
import '../chara_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CharaContainer extends StatelessWidget {
  final List listPaths;

  const CharaContainer({Key key, this.listPaths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: listPaths.length,
          scrollDirection: Axis.horizontal,
          // store this controller in a State to save the carousel scroll position
          itemBuilder: (BuildContext context, int i) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider<CharaInfoBloc>(
                          create: (context) => CharaInfoBloc()
                            ..add(CharaInfoLoad(
                              id: listPaths[i]['id'],
                            )),
                          child: CharaInfoScreen(),
                        )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(8),
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 270,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Container(
                          foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          child: Container(
                            height: 270,
                            width: double.infinity,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: 270,
                              imageUrl: listPaths[i]['img'],
                              placeholder: (context, url) => Container(
                                  color: Colors.grey,
                                  height: 270,
                                  child: Center(
                                      child: CupertinoActivityIndicator())),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                listPaths[i]['name'].toUpperCase(),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              "#${listPaths[i]['id']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "💰 Populer Comic Cheracter",
                          style: TextStyle(fontSize: 10),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class CharaContainerDoc extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> doc;

  const CharaContainerDoc({Key key, this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: doc.data()['characters'].length,
          scrollDirection: Axis.horizontal,
          // store this controller in a State to save the carousel scroll position
          itemBuilder: (BuildContext context, int i) {
            final data = doc.data()['characters'];

            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider<CharaInfoBloc>(
                          create: (context) => CharaInfoBloc()
                            ..add(CharaInfoLoad(
                              id: data[i]['id'],
                            )),
                          child: CharaInfoScreen(),
                        )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: .7,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(8),
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 270,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Container(
                          foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          child: Container(
                            height: 270,
                            width: double.infinity,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: 270,
                              imageUrl:
                                  "${data[i]['thumbnail']['path']}.${data[i]['thumbnail']['extension']}",
                              placeholder: (context, url) => Container(
                                  color: Colors.grey,
                                  height: 270,
                                  child: Center(
                                      child: CupertinoActivityIndicator())),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                data[i]['name'].toUpperCase(),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              " ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          " ",
                          style: TextStyle(fontSize: 10),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
