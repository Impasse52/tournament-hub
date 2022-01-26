import 'package:flutter/material.dart';

class SearchHistoryTile extends StatelessWidget {
  const SearchHistoryTile({
    required this.historyEntry,
    Key? key,
  }) : super(key: key);

  final String historyEntry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        border: Border.all(
          color: Colors.grey,
          width: 0.9,
        ),
      ),
      child: Center(child: Text(historyEntry)),
    );
  }
}
