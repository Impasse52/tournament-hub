import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tournament_hub/data/repositories/repositories.dart';
import 'package:tournament_hub/data/repositories/state_repository.dart';
import 'package:tournament_hub/ui/components/event_tile.dart';

class EventsList extends StatelessWidget {
  const EventsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateRepository>(context, listen: false);
    final smashgg = Provider.of<SmashggRepository>(context, listen: false);
    final tournament = state.currentTournament;

    return FutureBuilder(
      future: smashgg.getEventListByTournamentSlug(tournament.slug),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          state.eventList = snapshot.data;

          if (state.eventList.isNotEmpty) {
            final eventTiles = state.eventList
                .map(
                  (e) => InkWell(
                    child: EventTile(event: e),
                    borderRadius: BorderRadius.circular(25.0),
                    onTap: () => state.goToEventScreen(e),
                    // onTap: () => smashgg.getEventById(e.id),
                  ),
                )
                .toList();

            return ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount: state.eventList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 4.0),
              itemBuilder: (context, index) => eventTiles[index],
            );
          }

          return const Center(child: Text("No events were found :("));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
