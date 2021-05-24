import 'package:flutter/material.dart';
import 'package:marvelapp/screens/comic_search/comics_search.dart';
import 'package:marvelapp/screens/comic_search/cubit/searchcomics_cubit.dart';
import 'package:marvelapp/screens/comic_search/initalcomics.dart';
import 'all_characters.dart';
import '../blocs/fetch_home/fetch_home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/charcter_carousol.dart';
import 'widgets/comics_caurosol.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Marvel",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.info_outline, color: Colors.red),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "About an App",
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              "Marvel info. includes all comics,characters and creators information."),
                          SizedBox(height: 10),
                          Text("Made in Flutter platform."),
                          SizedBox(height: 10),
                          Text("Powered by Marvel API"),
                        ],
                      ),
                      actions: [
                        FlatButton(
                          child: Text("Close"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  });
            },
          )),
      body: BlocBuilder<FetchHomeBloc, FetchHomeState>(
        builder: (context, state) {
          if (state is FetchHomeLoading) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text("Please wait till We fetch data..",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500))
                ],
              ),
            );
          } else if (state is FetchHomeError) {
            return Center(
              child: Text("Something went wrong😒."),
            );
          } else if (state is FetchHomeSucess) {
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                header("Populer Marvel's charactors", () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AllCharacters()));
                }),
                SliverToBoxAdapter(
                    child: CharaContainer(
                  listPaths: state.characters,
                )),
                header("New Spider-Man comics", () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider<SearchcomicsCubit>(
                      create: (context) =>
                          SearchcomicsCubit()..onSubmitted("spider-man"),
                      child: InitalComics(),
                    ),
                  ));
                }),
                SliverToBoxAdapter(
                    child: ImageContainer(
                  comicspider: state.spidermanComics,
                )),
                header("Avengers Populer comics", () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider<SearchcomicsCubit>(
                      create: (context) =>
                          SearchcomicsCubit()..onSubmitted("avangers"),
                      child: InitalComics(),
                    ),
                  ));
                }),
                SliverToBoxAdapter(
                    child: ImageContainer(
                  comicspider: state.avengersComics,
                )),
                header("Populer Marvel Female Characters", () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AllCharacters()));
                }),
                SliverToBoxAdapter(
                  child: CharaContainer(
                    listPaths: state.femaleCharacters,
                  ),
                ),
                header("New Iron-man comics", () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider<SearchcomicsCubit>(
                      create: (context) =>
                          SearchcomicsCubit()..onSubmitted("iron man"),
                      child: InitalComics(),
                    ),
                  ));
                }),
                SliverToBoxAdapter(
                    child: ImageContainer(
                  comicspider: state.ironmanComics,
                )),
                header("Popular Captain America comics", () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider<SearchcomicsCubit>(
                      create: (context) =>
                          SearchcomicsCubit()..onSubmitted("captain america"),
                      child: InitalComics(),
                    ),
                  ));
                }),
                SliverToBoxAdapter(
                    child: ImageContainer(
                  comicspider: state.captainAmericaComics,
                )),
                header("Popular X-Men comics", () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider<SearchcomicsCubit>(
                      create: (context) =>
                          SearchcomicsCubit()..onSubmitted("x-men"),
                      child: InitalComics(),
                    ),
                  ));
                }),
                SliverToBoxAdapter(
                    child: ImageContainer(
                  comicspider: state.xmenComics,
                )),
              ],
            );
          } else if (state is FetchHomeNetWorkError) {
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
                    SizedBox(height: 10),
                    Text(
                      "Have another try?",
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      textColor: Colors.white,
                      elevation: 0,
                      color: Colors.red,
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    FetchHomeBloc()..add(FecthLoadContent()),
                                child: Home(),
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

  SliverAppBar header(String info, Function ontap) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        info.toUpperCase(),
        style: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            elevation: 0.0,
            onPressed: ontap,
            child: Text("SEE ALL"),
          ),
        ),
      ],
    );
  }
}
