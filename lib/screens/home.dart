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
      ),
      body: BlocBuilder<FetchHomeBloc, FetchHomeState>(
        builder: (context, state) {
          if (state is FetchHomeLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FetchHomeError) {
            return Center(
              child: Text(state.error.msg),
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
          }
          return Container();
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
