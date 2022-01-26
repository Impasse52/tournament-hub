import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SmashggService with ChangeNotifier {
  static Future<QueryResult> query(
      String query, Map<String, dynamic> variables) async {
    const _endpoint = 'https://api.smash.gg/gql/alpha';
    final jsonFile = await rootBundle.loadString('assets/smashgg_auth.json');
    final smashggAuth = jsonDecode(jsonFile)["smashgg_auth"];

    final HttpLink httpLink = HttpLink(_endpoint);

    final AuthLink authLink =
        AuthLink(getToken: () async => 'Bearer $smashggAuth');

    final Link link = authLink.concat(httpLink);

    final GraphQLClient client =
        GraphQLClient(link: link, cache: GraphQLCache());

    final parsedQuery = gql(query);

    return client.query(
      QueryOptions(
        document: parsedQuery,
        variables: variables,
      ),
    );
  }
}
