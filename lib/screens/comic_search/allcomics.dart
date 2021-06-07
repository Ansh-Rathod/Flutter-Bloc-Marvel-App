import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvelapp/blocs/bloc.dart';
import 'package:marvelapp/blocs/charaters_bloc/chara_info_bloc.dart';
import 'package:marvelapp/blocs/comic.dart';
import 'package:marvelapp/blocs/comic_info/comic_info_bloc.dart';
import 'package:marvelapp/screens/chara_info.dart';
import 'package:marvelapp/screens/comic_info.dart';
import 'package:marvelapp/screens/comic_search/comics_search.dart';
import 'package:marvelapp/screens/comic_search/cubit/searchcomics_cubit.dart';
import 'package:marvelapp/screens/cubits/searchCubit/search_page_cubit.dart';
import 'package:marvelapp/screens/widgets/search_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ComicSearchPage extends StatefulWidget {
  ComicSearchPage({Key key}) : super(key: key);

  @override
  _ComicSearchPageState createState() => _ComicSearchPageState();
}

class _ComicSearchPageState extends State<ComicSearchPage> {
  ComicBloc movieListBloc;

  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    movieListBloc = ComicBloc();
    movieListBloc.fetchFirstList();
    controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      print("at the end of list");
      movieListBloc.fetchNextMovies();
    }
  }

  final pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<DocumentSnapshot>>(
        stream: movieListBloc.movieStream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return PageView(
              controller: pageController,
              children: [
                CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  controller: controller,
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      elevation: 0,
                      title: Text(
                        "Marvel Comics",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(12.0),
                      sliver: SliverToBoxAdapter(
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText: "Search Comics e.g. Avengers",
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {},
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 5,
                                    style: BorderStyle.solid,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(15))),
                          onTap: () {
                            pageController.jumpToPage(1);
                          },
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(8.0),
                      sliver: SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                MediaQuery.of(context).size.width > 500 ? 4 : 2,
                            childAspectRatio: (9 / 16),
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 7,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (_, i) {
                              return Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider<ComicInfoBloc>(
                                                    create: (context) =>
                                                        ComicInfoBloc()
                                                          ..add(ComicInfoLoad(
                                                              snapshot.data[i]
                                                                  ['id'])),
                                                    child: ComicInfoScreen(),
                                                  )));
                                    },
                                    child: Container(
                                      foregroundDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: .7,
                                            ),
                                          ],
                                          color: Colors.grey,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                "${snapshot.data[i]['thumbnail']['path']}.${snapshot.data[i]['thumbnail']['extension']}",
                                              ))),
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10))),
                                        width: double.infinity,
                                        padding: EdgeInsets.all(8),
                                        child: Text(
                                          snapshot.data[i]['title'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            childCount: snapshot.data.length,
                          )),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            child: SpinKitThreeBounce(
                              color: Colors.red,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                BlocProvider(
                  create: (context) => SearchcomicsCubit(),
                  child: ComicSearchInputPage(),
                ),
              ],
            );
          } else {
            return Center(
                child: SpinKitThreeBounce(
              color: Colors.red,
              size: 30.0,
            ));
          }
        },
      ),
    );
  }
}
