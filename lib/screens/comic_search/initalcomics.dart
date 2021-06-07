import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marvelapp/blocs/comic_info/comic_info_bloc.dart';
import 'package:marvelapp/screens/comic_info.dart';
import 'package:marvelapp/screens/comic_search/cubit/searchcomics_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class InitalComics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchcomicsCubit, SearchcomicsState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "comics",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: state.status == ComicStatus.loading
            ? Center(
                child: SpinKitThreeBounce(
                  color: Colors.red,
                  size: 50.0,
                ),
              )
            : state.status == ComicStatus.success
                ? GridComics(comics: state.comics)
                : state.status == ComicStatus.error
                    ? Center(child: Text("Comics Not found"))
                    : state.comics == null
                        ? Center(
                            child: Text(
                            "404\nComics Not found.",
                            textAlign: TextAlign.center,
                          ))
                        : Container(),
      );
    });
  }
}

class GridComics extends StatelessWidget {
  final List comics;

  const GridComics({Key key, this.comics}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 9 / 16,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: MediaQuery.of(context).size.width > 500 ? 4 : 2,
          ),
          itemCount: comics.length,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider<ComicInfoBloc>(
                      create: (context) => ComicInfoBloc()
                        ..add(
                          ComicInfoLoad(
                            comics[i]['id'],
                          ),
                        ),
                      child: ComicInfoScreen(),
                    ),
                  ),
                );
              },
              child: Container(
                foregroundDecoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                      ),
                    ],
                    color: Colors.grey,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          "${comics[i]['thumbnail']['path']}.${comics[i]['thumbnail']['extension']}",
                        ))),
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    comics[i]['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
