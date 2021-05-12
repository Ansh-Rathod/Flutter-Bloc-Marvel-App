import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../blocs/charaters_bloc/chara_info_bloc.dart';
import 'widgets/comics_caurosol.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart';

class CharaInfoScreen extends StatelessWidget {
  CharaInfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CharaInfoBloc, CharaInfoState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is CharaInfoLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CharaInfoSuccess) {
            final data = state.snapshot.data();

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
                        "#${state.snapshot.data()['id']}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(8.0),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                      "${data['thumbnail']['path']}.${data['thumbnail']['extension']}"))),
                        ),
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
                              data['name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8),
                            child: Text(
                              _parseHtml(data['description']),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
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
                          ),
                        ],
                      ),
                    ),
                    if (state.comics.data()['comics'].isNotEmpty)
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
                    SliverPadding(
                      padding: EdgeInsets.all(8),
                      sliver: SliverToBoxAdapter(
                          child: ImageContainerDoc(
                        comicspider: state.comics,
                      )),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: 30),
                    )
                  ],
                ),
              ),
            );
          } else if (state is CharaInfoError) {
            return Center(child: Text("error"));
          }
        },
      ),
    );
  }

  String _parseHtml(String html) {
    final doc = parse(html);
    final String parsedString = parse(doc.body.text).documentElement.text;
    return parsedString;
  }
}
