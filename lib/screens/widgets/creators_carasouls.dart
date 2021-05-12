import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marvelapp/blocs/charaters_bloc/chara_info_bloc.dart';
import 'package:marvelapp/blocs/creator_bloc/creator_info_bloc.dart';
import 'package:marvelapp/screens/chara_info.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../creators_screen.dart';

class CreatorContainerDoc extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> doc;

  const CreatorContainerDoc({Key key, this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: doc.data()['Creators'].length,
          scrollDirection: Axis.horizontal,
          // store this controller in a State to save the carousel scroll position
          itemBuilder: (BuildContext context, int i) {
            final data = doc.data()['Creators'];
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<CreatorInfoBloc>(
                        create: (context) => CreatorInfoBloc()
                          ..add(
                            CreatorInfoLoad(
                              data[i]['id'],
                            ),
                          ),
                        child: CreatorsInfoScreen(),
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: .7,
                        ),
                      ],
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(8),
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 200,
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
                            height: 200,
                            width: double.infinity,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: 200,
                              imageUrl:
                                  "${data[i]['thumbnail']['path']}.${data[i]['thumbnail']['extension']}",
                              placeholder: (context, url) => Container(
                                  color: Colors.grey,
                                  height: 200,
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
                        child: Flexible(
                          child: Text(
                            data[i]['fullName'].toUpperCase(),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
