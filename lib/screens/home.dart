import 'package:flutter/material.dart';
import 'package:marvelapp/screens/comic_search/comics_search.dart';
import 'package:marvelapp/screens/comic_search/cubit/searchcomics_cubit.dart';
import 'package:marvelapp/screens/comic_search/initalcomics.dart';
import 'all_characters.dart';
import '../blocs/fetch_home/fetch_home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/charcter_carousol.dart';
import 'widgets/comics_caurosol.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
      ),
      body: BlocBuilder<FetchHomeBloc, FetchHomeState>(
        builder: (context, state) {
          if (state is FetchHomeLoading) {
            return Center(
                child: SpinKitThreeBounce(
              color: Colors.red,
              size: 50.0,
            ));
          } else if (state is FetchHomeError) {
            return Center(
              child: Text("Something went wrong😒."),
            );
          } else if (state is FetchHomeSucess) {
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: header("Populer Marvel's charactors", () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AllCharacters()));
                  }),
                ),
                SliverToBoxAdapter(
                    child: CharaContainer(
                  listPaths: state.characters,
                )),
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: header("New Spider-Man comics", () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider<SearchcomicsCubit>(
                        create: (context) =>
                            SearchcomicsCubit()..onSubmitted("spider-man"),
                        child: InitalComics(),
                      ),
                    ));
                  }),
                ),
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
                SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: header("Populer Marvel Female Characters", () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllCharacters()));
                    })),
                SliverToBoxAdapter(
                  child: CharaContainer(
                    listPaths: state.femaleCharacters,
                  ),
                ),
                SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: header("New Iron-man comics", () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider<SearchcomicsCubit>(
                          create: (context) =>
                              SearchcomicsCubit()..onSubmitted("iron man"),
                          child: InitalComics(),
                        ),
                      ));
                    })),
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
                SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: header("Popular X-Men comics", () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider<SearchcomicsCubit>(
                          create: (context) =>
                              SearchcomicsCubit()..onSubmitted("x-men"),
                          child: InitalComics(),
                        ),
                      ));
                    })),
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
                      "Please,Check your internet connection",
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
        InkWell(
          onTap: ontap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Icon(Icons.arrow_right_alt_outlined,
                size: 35, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
