import 'package:flutter/material.dart';
import 'package:tournament_hub/navigation/app_link.dart';

class AdvancedSearchScreen extends StatelessWidget {
  const AdvancedSearchScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      name: AppLink.advancedSearch,
      key: ValueKey(AppLink.advancedSearch),
      child: const AdvancedSearchScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.pink);
  }
}
