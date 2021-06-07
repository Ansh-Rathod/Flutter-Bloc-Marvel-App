import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvelapp/screens/image_grid.dart';
import 'package:marvelapp/screens/image_view.dart';
import 'package:marvelapp/screens/widgets/charcter_carousol.dart';
import 'package:marvelapp/screens/widgets/creators_carasouls.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../blocs/comic_info/comic_info_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ComicInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ComicInfoBloc, ComicInfoState>(
        builder: (context, state) {
          if (state is ComicInfoLoading) {
            return Center(
                child: SpinKitThreeBounce(
              color: Colors.red,
              size: 50.0,
            ));
          } else if (state is ComicInfoSuccess) {
            final data = state.comicInfo.data();
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width > 500
                    ? 500
                    : MediaQuery.of(context).size.width,
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      pinned: true,
                      title: Text(
                        "About Comic",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            foregroundDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "${state.comicInfo.data()['thumbnail']['path']}.${state.comicInfo.data()['thumbnail']['extension']}",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.comicInfo.data()['title'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (state.comicInfo.data()['description'] != null)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "${state.comicInfo.data()['description']}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8.0),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(blurRadius: 1, color: Colors.grey),
                            ],
                            border: Border.all(
                              color: Colors.grey.withOpacity(.7),
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Format:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${data['format']}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Pages:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${data['pageCount']}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(.6),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                ),
                                width: 80,
                                height: 80,
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                    width: 70,
                                    height: 70,
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "\$${state.comicInfo.data()['prices'][0]['price'].floor()}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    if (data['images'].isNotEmpty)
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Text("Images",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    if (data['images'].isNotEmpty)
                      SliverPadding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        sliver: SliverToBoxAdapter(
                          child: PhotoGrid(
                            imageUrls: data['images'],
                            onImageClicked: (i) {
                              pushNewScreen(
                                context,
                                screen: ViewPhotos(
                                  imageIndex: i,
                                  imageList: data['images'],
                                ),

                                pageTransitionAnimation:
                                    PageTransitionAnimation.slideUp,

                                withNavBar: false, // OPTIONAL VALUE. True by
                              );
                            },
                            onExpandClicked: () {
                              pushNewScreen(
                                context,
                                screen: ViewPhotos(
                                  imageIndex: 3,
                                  imageList: data['images'],
                                ),
                                pageTransitionAnimation:
                                    PageTransitionAnimation.slideUp,
                                withNavBar: false, // OPTIONAL VALUE. True by
                              );
                            },
                            maxImages: 4,
                          ),
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    if (state.comicCharacters.data()['characters'].isNotEmpty)
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Text("Characters",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    if (state.comicCharacters.data()['characters'].isNotEmpty)
                      SliverToBoxAdapter(
                        child: CharaContainerDoc(
                          doc: state.comicCharacters,
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    if (state.comicCreators.data()['Creators'].isNotEmpty)
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Text("Creators",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    if (state.comicCreators.data()['Creators'].isNotEmpty)
                      SliverToBoxAdapter(
                        child: CreatorContainerDoc(
                          doc: state.comicCreators,
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          alignment: Alignment.center,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ...(data['urls'] as List)
                                      .map((type) => Row(
                                            children: [
                                              RaisedButton(
                                                  color: Colors.red,
                                                  elevation: 0,
                                                  textColor: Colors.white,
                                                  onPressed: () async {
                                                    await launch(type['url']);
                                                  },
                                                  child: Text(type['type']
                                                      .toUpperCase())),
                                              SizedBox(width: 20)
                                            ],
                                          ))
                                      .toList(),
                                ]),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ComicInfoError) {
            return Center(child: Text("Error"));
          } else if (state is ComicInfoNetWorkError) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Please,Check your internet connection and",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(),
                    SizedBox(height: 10),
                    RaisedButton(
                      textColor: Colors.white,
                      elevation: 0,
                      color: Colors.red,
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider<ComicInfoBloc>(
                                create: (context) => ComicInfoBloc()
                                  ..add(
                                    ComicInfoLoad(state.uid),
                                  ),
                                child: ComicInfoScreen(),
                              ),
                            ));
                      },
                      child: Text("Try again"),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
