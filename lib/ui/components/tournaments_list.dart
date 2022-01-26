import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_hub/data/models/models.dart';
import 'package:tournament_hub/data/repositories/repositories.dart';
import 'package:tournament_hub/ui/components/tournament_tile.dart';

class TournamentsList extends StatefulWidget {
  final List<Tournament> list;

  const TournamentsList({
    required this.list,
    Key? key,
  }) : super(key: key);

  @override
  State<TournamentsList> createState() => _TournamentsListState();
}

// TODO: implement infinite list
class _TournamentsListState extends State<TournamentsList> {
  StateRepository? state;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      state = Provider.of<StateRepository>(context, listen: false);
    });
    getBookmarkedTournaments();
  }

  void getBookmarkedTournaments() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("bookmarkedTournaments")) {
      List<String> tournaments =
          prefs.getStringList("bookmarkedTournaments") ?? [];

      if (tournaments.isNotEmpty) {
        // resets bookmarks list to prevent duplicates
        state!.bookmarks = [];
        for (var t in tournaments) {
          state!.bookmarks.add(Tournament.fromJson(jsonDecode(t)));
        }
      } else {
        state!.bookmarks = <Tournament>[];
      }
    }
  }

  void saveBookmarkedTournaments() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> tournamentJson = <String>[];

    for (var t in state!.bookmarks) {
      tournamentJson.add(jsonEncode(t.toJson(t)));
    }

    // sets updated list
    prefs.setStringList("bookmarkedTournaments", tournamentJson);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 5.0),
      itemCount: widget.list.length,
      itemBuilder: (BuildContext context, int index) {
        final tournament = widget.list[index];

        return Slidable(
          direction: Axis.horizontal,
          dragStartBehavior: DragStartBehavior.start,
          endActionPane: ActionPane(
            motion: const BehindMotion(),
            children: [
              SlidableAction(
                autoClose: true,
                backgroundColor: Colors.transparent,
                foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
                icon: Icons.share,
                label: 'Share',
                onPressed: (context) =>
                    Share.share('https://smash.gg${tournament.url}'),
              ),
              SlidableAction(
                autoClose: true,
                backgroundColor: Colors.transparent,
                foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
                label: 'Save',
                icon: (state?.bookmarks ?? []).contains(tournament)
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                onPressed: (context) {
                  final bookmarks = state!.bookmarks;

                  if (!bookmarks.contains(tournament)) {
                    bookmarks.add(tournament);
                    saveBookmarkedTournaments();
                    state!.modifyBookmarks();
                  } else {
                    bookmarks.remove(tournament);
                    saveBookmarkedTournaments();
                    state!.modifyBookmarks();
                  }
                },
              ),
            ],
          ),
          child: Consumer(
            builder: (_, StateRepository repository, __) {
              return InkWell(
                child: TournamentTile(tournament: tournament),
                onTap: () {
                  repository.goToEventList(tournament);
                },
                borderRadius: BorderRadius.circular(25.0),
              );
            },
          ),
        );
      },
    );
  }
}
