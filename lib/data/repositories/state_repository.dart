import 'package:flutter/material.dart';
import 'package:tournament_hub/data/models/models.dart';

class StateRepository extends ChangeNotifier {
  static final _emptyTournament = Tournament(
    id: '-1',
    name: '',
    slug: '',
    imageUrl: '',
    bannerUrl: '',
    bannerWidth: 1,
    bannerHeight: 1,
    isOnline: false,
    numAttendees: '',
    city: '',
    startAt: DateTime(0),
    endAt: DateTime(0),
    hasOfflineEvents: false,
    hasOnlineEvents: false,
    url: '',
  );

  get emptyTournament => _emptyTournament;

  static final Event _emptyEvent = Event(
    id: '-1',
    slug: '',
    name: '',
    tournamentId: '',
    tournamentSlug: '',
    tournamentName: '',
    state: '',
    numEntrants: '',
    isOnline: false,
    createdAt: DateTime(0),
    startAt: DateTime(0),
    updatedAt: DateTime(0),
  );

  get emptyEvent => _emptyEvent;

  int currentTab = 0;

  List<Tournament> tournamentList = [];

  List<Tournament> bookmarks = <Tournament>[];

  List<Event> eventList = [];

  Tournament currentTournament = _emptyTournament;

  Event currentEvent = _emptyEvent;

  bool hasSorted = false;
  bool isSearching = false;
  bool isFiltering = false;

  // used to prevent notifyListeners() from reversing sorting
  bool isSorting = false;

  void sortTournaments() {
    hasSorted
        ? tournamentList.sort((a, b) => a.name.compareTo(b.name))
        : tournamentList.sort((a, b) => a.startAt.compareTo(b.startAt));

    hasSorted = !hasSorted;
    isSorting = true;

    notifyListeners();
  }

  void searchTournaments() {
    isSearching = true;
    notifyListeners();
  }

  void goToAdvancedSearch() {
    isFiltering = true;
    notifyListeners();
  }

  void returnFromAdvancedSearch() {
    isFiltering = false;
    notifyListeners();
  }

  void goToTab(int index) {
    currentTab = index;
    notifyListeners();
  }

  void goToEventList(Tournament tournament) {
    currentTournament = tournament;
    notifyListeners();
  }

  void returnFromEventList() {
    currentTournament = _emptyTournament;
    notifyListeners();
  }

  void goToEventScreen(Event event) {
    currentEvent = event;
    notifyListeners();
  }

  void returnFromEventScreen() {
    currentEvent = emptyEvent;
    notifyListeners();
  }

  void modifyBookmarks() {
    notifyListeners();
  }
}
