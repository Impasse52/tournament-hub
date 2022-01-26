import 'package:flutter/material.dart';
import 'package:tournament_hub/navigation/app_link.dart';
import 'package:tournament_hub/data/repositories/repositories.dart';
import 'package:tournament_hub/ui/screens/screens.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final StateRepository stateRepository;
  final SmashggRepository smashggRepository;

  AppRouter({
    required this.stateRepository,
    required this.smashggRepository,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    stateRepository.addListener(notifyListeners);
    smashggRepository.addListener(notifyListeners);
  }

  @override
  void dispose() {
    stateRepository.removeListener(notifyListeners);
    smashggRepository.removeListener(notifyListeners);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        // home route
        Home.page(),
        // event list
        if (stateRepository.currentTournament.id != "-1") ...[
          EventListScreen.page(),
        ],
        // event screen
        if (stateRepository.currentEvent.id != "-1") ...[
          EventScreen.page(),
        ],
        // advanced search screen
        if (stateRepository.isFiltering) ...[
          AdvancedSearchScreen.page(),
        ],
      ],
    );
  }

  // called when pressing any back button
  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (route.settings.name == AppLink.eventList) {
      stateRepository.returnFromEventList();
    }

    if (route.settings.name == AppLink.eventScreen) {
      stateRepository.returnFromEventScreen();
    }

    if (route.settings.name == AppLink.advancedSearch) {
      stateRepository.returnFromAdvancedSearch();
    }

    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}
}
