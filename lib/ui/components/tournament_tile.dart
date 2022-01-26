import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tournament_hub/data/models/models.dart';

class TournamentTile extends StatelessWidget {
  const TournamentTile({
    required this.tournament,
    Key? key,
  }) : super(key: key);

  final Tournament tournament;

  // TODO: try putting either logo or banner in the tile's background
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[700] as Color, width: 0.5),
        color: Colors.black38,
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTournamentLogo(context, 100.0, 100.0),
            ],
          ),
          const SizedBox(width: 10.0),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTournamentTitle(context),
                const SizedBox(height: 8.0),
                Row(children: [_buildParticipants()]),
                const SizedBox(height: 0),
                _buildChips(context),
              ],
            ),
          )

          // _buildChips(),
        ],
      ),
    );
  }

  Widget _buildTournamentLogo(context, height, radius) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: tournament.imageUrl.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: tournament.imageUrl,
              height: height,
              fit: BoxFit.fitHeight,
              placeholder: (context, url) => const SizedBox(width: 100),
            )
          : Container(width: 100, color: Colors.grey),
    );
  }

  Widget _buildTournamentTitle(BuildContext context) {
    String sanitizedName = '';

    // truncates longer names
    tournament.name.length > 45
        ? sanitizedName =
            '${tournament.name.substring(0, tournament.name.length - 10)}...'
        : sanitizedName = tournament.name;

    return Text(
      sanitizedName,
      style: Theme.of(context).textTheme.headline3,
    );
  }

  Widget _buildParticipants() {
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    final date = formatter.format(tournament.startAt);

    return Row(
      children: [
        Text(
          "${tournament.numAttendees} PLAYERS | $date",
          style: const TextStyle(letterSpacing: 0.6),
        ),
      ],
    );
  }

  Widget _buildChips(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width, maxHeight: 50),
      child: ListView(
        padding: const EdgeInsets.only(top: 4.0),
        scrollDirection: Axis.horizontal,
        children: [
          tournament.isOnline ? const Chip(label: Text("ONLINE")) : Container(),
          const SizedBox(width: 2.0),
          const Chip(label: Text("SMASH BROS. ULTIMATE")),
          const SizedBox(width: 2.0),
        ],
      ),
    );
  }
}
