import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tournament_hub/data/models/models.dart';

class EventTile extends StatelessWidget {
  const EventTile({
    required this.event,
    Key? key,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[700] as Color, width: 0.5),
        color: Colors.black38,
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Wrap(
                  children: [
                    Text(
                      event.name,
                      style: Theme.of(context).textTheme.headline4,
                    )
                  ],
                ),
              ),
              Text(
                event.state,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${event.numEntrants} attendees',
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                // TODO: format date
                'Played on ${DateFormat("dd-MM-yyyy").format(event.startAt).toString()}',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
