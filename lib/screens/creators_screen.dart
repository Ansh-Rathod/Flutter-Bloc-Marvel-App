import 'package:flutter/material.dart';
import 'package:marvelapp/blocs/creator_bloc/creator_info_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:marvelapp/screens/widgets/comics_caurosol.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CreatorsInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CreatorInfoBloc, CreatorInfoState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is CreatorInfoLoading) {
            return Center(
                child: SpinKitThreeBounce(
              color: Colors.red,
              size: 50.0,
            ));
          } else if (state is CreatorInfoSuccess) {
            final data = state.creatorInfo.data();

            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width > 500
                    ? 500
                    : MediaQuery.of(context).size.width,
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      elevation: 0,
                      backgroundColor: Colors.white,
                      iconTheme: IconThemeData(color: Colors.black),
                      title: Text(
                        "#${data['id']}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
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
                                        "${data['thumbnail']['path']}.${data['thumbnail']['extension']}"))),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              data['fullName'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            alignment: Alignment.center,
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: (data['urls'] as List)
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
                                            SizedBox(width: 20),
                                          ],
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (state.creatorComics.data()['comics'].isNotEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "Popular Comics",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    if (state.creatorComics.data()['comics'].isNotEmpty)
                      SliverPadding(
                        padding: EdgeInsets.all(8),
                        sliver: SliverToBoxAdapter(
                            child: ImageContainerDoc(
                          comicspider: state.creatorComics,
                        )),
                      ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: 30),
                    )
                  ],
                ),
              ),
            );
          } else if (state is CreatorInfoError) {
            return Center(child: Text("Somthing Wents wrong😒"));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
