import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvelapp/screens/image_grid.dart';
import 'package:marvelapp/screens/image_view.dart';
import 'package:marvelapp/screens/widgets/charcter_carousol.dart';
import 'package:marvelapp/screens/widgets/creators_carasouls.dart';
import '../blocs/comic_info/comic_info_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class ComicInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ComicInfoBloc, ComicInfoState>(
        builder: (context, state) {
          if (state is ComicInfoLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
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
                        "#${state.comicInfo.data()['id']}",
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
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
                          horizontal: 40.0, vertical: 8.0),
                      sliver: SliverToBoxAdapter(
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
                                  shape: BoxShape.circle),
                              width: 70,
                              height: 70,
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                  width: 60,
                                  height: 60,
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "\$${state.comicInfo.data()['prices'][0]['price']}",
                                      overflow: TextOverflow.ellipsis,
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
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          alignment: Alignment.center,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                        height: 10,
                      ),
                    ),
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
                    SliverPadding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      sliver: SliverToBoxAdapter(
                        child: PhotoGrid(
                          imageUrls: data['images'],
                          onImageClicked: (i) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewPhotos(
                                          imageIndex: i,
                                          imageList: data['images'],
                                        )));
                          },
                          onExpandClicked: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewPhotos(
                                          imageIndex: 3,
                                          imageList: data['images'],
                                        )));
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
                      SliverPadding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        sliver: SliverToBoxAdapter(
                          child: CharaContainerDoc(
                            doc: state.comicCharacters,
                          ),
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
                      SliverPadding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        sliver: SliverToBoxAdapter(
                          child: CreatorContainerDoc(
                            doc: state.comicCreators,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          } else if (state is ComicInfoError) {
            return Center(child: Text("Error"));
          }
        },
      ),
    );
  }
}
