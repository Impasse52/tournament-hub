import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tournament_hub/data/repositories/repositories.dart';
import 'package:tournament_hub/ui/components/tournaments_list.dart';

class BookmarksTab extends StatelessWidget {
  const BookmarksTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<StateRepository>(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(6.0),
        child: state.bookmarks.isNotEmpty
            ? TournamentsList(list: state.bookmarks)
            : const Center(child: Text("No bookmarks yet :(")),
      ),
    );
  }
}
