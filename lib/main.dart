import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tournament_hub/data/repositories/state_repository.dart';
import 'package:tournament_hub/navigation/app_router.dart';
import 'package:tournament_hub/theme.dart';

import 'data/repositories/smashgg_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TournamentHub());
}

class TournamentHub extends StatefulWidget {
  const TournamentHub({
    Key? key,
  }) : super(key: key);

  @override
  State<TournamentHub> createState() => _TournamentHubState();
}

class _TournamentHubState extends State<TournamentHub> {
  late AppRouter _appRouter;
  final StateRepository _stateRepository = StateRepository();
  final SmashggRepository _smashggRepository = SmashggRepository();

  @override
  void initState() {
    super.initState();

    _appRouter = AppRouter(
      stateRepository: _stateRepository,
      smashggRepository: _smashggRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = TournamentHubTheme.dark();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _smashggRepository),
        ChangeNotifierProvider(create: (context) => _stateRepository),
      ],
      child: MaterialApp(
        title: 'Tournament Hub',
        theme: theme,
        home: Router(
          routerDelegate: _appRouter,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
