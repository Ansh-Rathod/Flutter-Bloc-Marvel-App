import 'package:flutter/material.dart';
import 'package:marvelapp/blocs/fetch_home/fetch_home_bloc.dart';
import 'package:marvelapp/screens/all_characters.dart';
import 'package:marvelapp/screens/comic_search/allcomics.dart';
import 'package:marvelapp/screens/home.dart';
import 'package:marvelapp/screens/widgets/search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavView extends StatefulWidget {
  @override
  _BottomNavViewState createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    BlocProvider(
      create: (context) => FetchHomeBloc()..add(FecthLoadContent()),
      child: Home(),
    ),
    AllCharacters(),
    ComicSearchPage(),
  ];
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey,
        icon: Icon(Icons.home),
        activeColorPrimary: Colors.red,
        title: ("Home"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey,
        icon: Icon(Icons.search),
        activeColorPrimary: Colors.red,
        title: ("Characters"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey,
        icon: Icon(Icons.book),
        activeColorPrimary: Colors.red,
        title: ("Comics"),
      ),
    ];
  }

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PersistentTabView(
        this.context,
        controller: _controller,
        screens: _widgetOptions,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        navBarStyle: NavBarStyle.style9,
      ),
    );
  }
}
