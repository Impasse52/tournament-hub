import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_hub/data/repositories/smashgg_repository.dart';
import 'package:tournament_hub/data/repositories/state_repository.dart';
import 'package:tournament_hub/ui/components/search_history_tile.dart';
import 'package:tournament_hub/ui/components/tournaments_list.dart';
import 'package:uuid/uuid.dart';

class SearchTournamentsTab extends StatefulWidget {
  const SearchTournamentsTab({Key? key}) : super(key: key);

  @override
  _SearchTournamentsTabState createState() => _SearchTournamentsTabState();
}

class _SearchTournamentsTabState extends State<SearchTournamentsTab> {
  final _controller = TextEditingController();
  List<String> searchHistory = <String>[];

  @override
  void initState() {
    super.initState();
    getBookmarkedTournaments();
  }

  void getBookmarkedTournaments() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("searchHistory")) {
      searchHistory = prefs.getStringList("searchHistory") ?? [];
    } else {
      searchHistory = [];
    }
  }

  void saveSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();

    searchHistory = [
      ...{...searchHistory}
    ];

    // sets updated list
    prefs.setStringList("searchHistory", searchHistory);
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<StateRepository>(context, listen: true);
    var smashgg = Provider.of<SmashggRepository>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          _buildSearchField(state),
          const SizedBox(height: 20.0),
          if (!state.isSearching) ...[
            _buildSearchHistory(),
          ],
          if (state.isSearching) ...[
            _buildSearchResults(state, smashgg),
          ],
        ],
      ),
    );
  }

  Widget _buildSearchField(StateRepository state) {
    return TextField(
      onSubmitted: (_) {
        state.searchTournaments();
        searchHistory.add(_controller.text);
        saveSearchHistory();
      },
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Enter your tournament\'s name here',
        suffixIconConstraints: const BoxConstraints(),
        suffixIcon: InkWell(
          child: Container(
            child: const Text("MORE"),
            padding: const EdgeInsets.all(20.0),
          ),
          onTap: () => state.goToAdvancedSearch(),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  Widget _buildSearchHistory() {
    return Expanded(
      child: ListView.builder(
        itemCount: searchHistory.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Dismissible(
                key: Key(const Uuid().v1()),
                child: InkWell(
                  child: SearchHistoryTile(
                    historyEntry: searchHistory[index],
                  ),
                  onTap: () {
                    _controller.text = searchHistory[index];
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                ),
                onDismissed: (direction) {
                  searchHistory.removeAt(index);
                  saveSearchHistory();
                },
              ),
              const SizedBox(height: 8.0),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchResults(StateRepository state, SmashggRepository smashgg) {
    return FutureBuilder(
      future: smashgg.getTournamentsByName(12, 1, _controller.text),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          state.tournamentList = snapshot.data;

          if (state.tournamentList.isNotEmpty) {
            return Expanded(
              child: TournamentsList(list: state.tournamentList),
            );
          }

          return const Expanded(
            child: Center(child: Text("No tournaments were found :(")),
          );
        }

        return const Expanded(
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
