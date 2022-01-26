import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tournament_hub/data/repositories/state_repository.dart';
import 'package:tournament_hub/navigation/app_link.dart';
import 'package:tournament_hub/ui/screens/bookmarks_tab.dart';
import 'package:tournament_hub/ui/screens/featured_tournaments_tab.dart';
import 'package:tournament_hub/ui/screens/screens.dart';

class Home extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: AppLink.home,
      key: ValueKey(AppLink.home),
      child: const Home(),
    );
  }

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<Widget> pages = <Widget>[
    const FeaturedTournamentsTab(),
    const SearchTournamentsTab(),
    const BookmarksTab(),
  ];

  var items = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.explore),
      label: 'Featured',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search_rounded),
      label: 'Search',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.bookmark),
      label: 'Bookmarks',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<StateRepository>(
      builder: (_, state, __) {
        return Scaffold(
          // TODO: replace with an AppBarSliver
          appBar: AppBar(title: const Text("Tournament Hub")),
          // TODO: implement tournament history in drawer
          drawer: const Drawer(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentTab,
            onTap: (int index) => state.goToTab(index),
            items: items,
          ),
          body: IndexedStack(index: state.currentTab, children: pages),
        );
      },
    );
  }
}
