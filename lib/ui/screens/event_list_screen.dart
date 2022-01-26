import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tournament_hub/data/repositories/state_repository.dart';
import 'package:tournament_hub/navigation/app_link.dart';
import 'package:tournament_hub/ui/components/events_list.dart';

class EventListScreen extends StatelessWidget {
  const EventListScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      name: AppLink.eventList,
      key: ValueKey(AppLink.eventList),
      child: const EventListScreen(),
    );
  }

  // simulates BoxFit.fitWidth
  Size fitWidth(BuildContext context, Size inputSize) {
    final state = Provider.of<StateRepository>(context);

    final inputSize = Size(
      state.currentTournament.bannerWidth + .0,
      state.currentTournament.bannerHeight + .0,
    );

    final outputSize = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height / 4,
    );

    final sourceSize = Size(
      inputSize.width,
      inputSize.width * outputSize.height / outputSize.width,
    );

    final destinationSize = Size(
      outputSize.width,
      sourceSize.height * outputSize.width / sourceSize.width,
    );

    return destinationSize;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StateRepository>(
      builder: (_, state, __) {
        // builds bannerSize by simulating Box.fitWidth
        // destinationSize is also used to build a placeholder
        final bannerSize = Size(
          state.currentTournament.bannerWidth + .0,
          state.currentTournament.bannerHeight + .0,
        );

        final destinationSize = fitWidth(context, bannerSize);

        return Scaffold(
          appBar: AppBar(
            title: Text(state.currentTournament.name),
          ),
          body: Column(
            children: [
              if (state.currentTournament != state.emptyTournament) ...[
                state.currentTournament.bannerUrl != ''
                    ? CachedNetworkImage(
                        fit: BoxFit.fitWidth,
                        imageUrl: state.currentTournament.bannerUrl,
                        placeholder: (context, url) => Container(
                          width: destinationSize.width,
                          height: destinationSize.height,
                          color: Colors.transparent,
                        ),
                      )
                    : Container(
                        height: destinationSize.height,
                        color: Colors.grey,
                      ),
              ],
              // TODO: add Sliver
              const Expanded(child: EventsList()),
            ],
          ),
        );
      },
    );
  }
}
