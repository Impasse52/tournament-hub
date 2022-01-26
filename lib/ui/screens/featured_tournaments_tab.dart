import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tournament_hub/data/repositories/repositories.dart';
import 'package:tournament_hub/ui/components/tournaments_list.dart';

// TODO: change back to grid
class FeaturedTournamentsTab extends StatelessWidget {
  const FeaturedTournamentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<StateRepository>(context);
    final smashgg = Provider.of<SmashggRepository>(context, listen: false);

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => state.sortTournaments(),
      //   child: const Icon(Icons.sort_by_alpha),
      // ),
      body: Container(
        padding: const EdgeInsets.all(6.0),
        child: FutureBuilder(
          future: smashgg.getFeaturedTournaments(12, 1),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              if (state.isSorting) {
                state.tournamentList = state.tournamentList;
              } else {
                state.tournamentList = snapshot.data;
              }

              return TournamentsList(list: state.tournamentList);
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
