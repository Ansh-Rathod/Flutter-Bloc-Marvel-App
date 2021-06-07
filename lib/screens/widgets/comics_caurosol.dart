import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marvelapp/blocs/comic_info/comic_info_bloc.dart';
import 'package:marvelapp/screens/comic_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageContainer extends StatelessWidget {
  final List comicspider;

  const ImageContainer({Key key, this.comicspider}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: ListView.builder(
          itemCount: comicspider.length,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<ComicInfoBloc>(
                        create: (context) => ComicInfoBloc()
                          ..add(
                            ComicInfoLoad(
                              comicspider[i]['id'],
                            ),
                          ),
                        child: ComicInfoScreen(),
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 150,
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
                            height: 230,
                            width: double.infinity,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: comicspider[i]['img'],
                              placeholder: (context, url) => Container(
                                  height: 230,
                                  color: Colors.grey,
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
                        child: Text(
                          comicspider[i]['name'],
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
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

class ImageContainerDoc extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> comicspider;

  const ImageContainerDoc({Key key, this.comicspider}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: ListView.builder(
          itemCount: comicspider.data()['comics'].length,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 150,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider<ComicInfoBloc>(
                                create: (context) => ComicInfoBloc()
                                  ..add(
                                    ComicInfoLoad(
                                      comicspider.data()['comics'][i]['id'],
                                    ),
                                  ),
                                child: ComicInfoScreen(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          child: Container(
                            height: 230,
                            width: double.infinity,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  "${comicspider.data()['comics'][i]['thumbnail']['path']}.${comicspider.data()['comics'][i]['thumbnail']['extension']}",
                              placeholder: (context, url) => Container(
                                  height: 230,
                                  color: Colors.grey,
                                  child: Center(
                                      child: CupertinoActivityIndicator())),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(9),
                      child: Text(
                        comicspider.data()['comics'][i]['title'],
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
