import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tournament_hub/data/repositories/state_repository.dart';
import 'package:tournament_hub/navigation/app_link.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      name: AppLink.eventScreen,
      key: ValueKey(AppLink.eventScreen),
      child: const EventScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateRepository>(context);
    final event = state.currentEvent;

    return Scaffold(
      appBar: AppBar(title: Text(event.name)),
      body: Container(
        padding: const EdgeInsets.all(6.0),
        child: ListView(
          children: [
            if (event.state == "COMPLETED") ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Standings",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              const SizedBox(height: 5.0),
              _buildTop8(),
            ],
          ],
        ),
      ),
    );
  }

  // TODO: write Standings model
  Widget _buildTop8() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        // color: Colors.black26,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildTop3Place("u", "2", 100.0),
              _buildTop3Place("gelfdm", "1", 125.0),
              _buildTop3Place("helooo", "3", 85.0),
            ],
          ),
          const SizedBox(height: 20.0),
          _buildTop5Place("helo", "4"),
          const SizedBox(height: 5.0),
          _buildTop5Place("helo", "5"),
          const SizedBox(height: 5.0),
          _buildTop5Place("helo", "5"),
          const SizedBox(height: 5.0),
          _buildTop5Place("helloo", "7"),
          const SizedBox(height: 5.0),
          _buildTop5Place("helolo", "7"),
          const SizedBox(height: 20.0),
          _viewAllStandings()
        ],
      ),
    );
  }

  Widget _buildTop3Place(String nickname, String placement, double width) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            child: CachedNetworkImage(
              imageUrl:
                  "https://pbs.twimg.com/profile_images/642831560782163968/NwTRyyuI_400x400.jpg",
              width: width,
            ),
          ),
          Wrap(
            children: [
              Text(nickname, style: TextStyle(fontSize: width / 5),),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTop5Place(String nickname, String placement) {
    return Row(
      children: [
        Text(placement),
        const SizedBox(width: 20.0),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          child: CachedNetworkImage(
            imageUrl:
                "https://pbs.twimg.com/profile_images/642831560782163968/NwTRyyuI_400x400.jpg",
            width: 40.0,
          ),
        ),
        const SizedBox(width: 20.0),
        Text(nickname),
      ],
    );
  }

  Widget _viewAllStandings() {
    return InkWell(
      child: Container(
        child: const Text("VIEW ALL STANDINGS"),
        padding: const EdgeInsets.all(6.0),
      ),
      onTap: () {},
    );
  }
}
