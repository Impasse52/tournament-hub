import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tournament_hub/data/models/models.dart';
import 'package:tournament_hub/network/smashgg_service.dart';

class SmashggRepository extends ChangeNotifier {
  Future<Tournament> getTournamentBySlug(String slug) async {
    var query = '''query TournamentBySlug(\$slug: String!) {
      tournament(slug: "\$slug"){
        id
        name
        slug
        numAttendees
        startAt
        endAt
        url
        city
        hasOfflineEvents
        hasOnlineEvents
        isOnline
        events {
          videogame {
            id
            name
          }
        }
        images {
          url
          type
        }
      }
    }''';

    var variables = {"slug": slug};
    QueryResult results = await SmashggService.query(query, variables);

    return Tournament.fromMap(results.data as Map<String, dynamic>);
  }

  Future<List<Tournament>> getTournamentsByName(
      int perPage, int page, String name) async {
    var query = '''
        query TournamentByName(\$perPage: Int!, \$page: Int!, \$name: String!) {
      tournaments(
        query: { perPage: \$perPage, page: \$page, filter: { name: \$name } }
      ) {
        nodes {
          id
          name
          slug
          numAttendees
          startAt
          endAt
          url
          city
          hasOfflineEvents
          hasOnlineEvents
          isOnline
          events {
          videogame {
            id
            name
          }
        }
          images {
            url
            type
          }
        }
      }
    }''';

    var variables = {"perPage": perPage, "page": page, "name": name};

    QueryResult results = await SmashggService.query(query, variables);

    List<Tournament> tournaments = [];
    for (var t in results.data!["tournaments"]["nodes"]) {
      tournaments.add(Tournament.fromMap(t));
    }

    return tournaments;
  }

  Future<List<Tournament>> getFeaturedTournaments(int perPage, int page) async {
    var query = '''
      query FeaturedTournament(\$perPage: Int!, \$page: Int!) {
        tournaments(
          query: { perPage: \$perPage, page: \$page, filter: 
          { isFeatured: true }
        }) {
          nodes {
            id
            name
            slug
            numAttendees
            startAt
            endAt
            url
            city
            hasOfflineEvents
            hasOnlineEvents
            isOnline
            events {
              videogame {
                id
                name
              }
            }
            images {
              url
              type
              width
              height
            }
          }
        }
      }
    ''';

    var variables = {"perPage": perPage, "page": page};

    QueryResult results = await SmashggService.query(query, variables);

    List<Tournament> tournaments = [];
    for (var t in results.data!["tournaments"]["nodes"]) {
      tournaments.add(Tournament.fromMap(t));
    }

    return tournaments;
  }

  Future<List<Event>> getEventListByTournamentSlug(String slug) async {
    var query = '''
      query EventListByTournamentSlug(\$slug: String!) {
        tournament(slug: \$slug) {
          events {
            id
            slug
            tournament {
              id
              slug
              name
            }
            name
            state
            numEntrants
            createdAt
            updatedAt
            startAt
            isOnline
          }
        }
      }
    ''';

    var variables = {"slug": slug};

    QueryResult results = await SmashggService.query(query, variables);

    List<Event> events = [];
    for (var e in results.data!["tournament"]["events"] ?? []) {
      events.add(Event.fromMap(e));
    }

    return events;
  }

  Future<Event> getEventById(String id) async {
    var query = '''
    query EventBySlug(\$id: ID) {
      event(id: \$id) {
        id
        slug
        tournament {
          id
          slug
          name
        }
        name
        state
        numEntrants
        createdAt
        updatedAt
        startAt
        isOnline 
      }
    }
    ''';

    var variables = {"id": id};
    QueryResult results = await SmashggService.query(query, variables);

    return Event.fromMap(results.data!["event"]);
  }
}

var fullTournamentQuery = '''
  query EventStandings {
    tournament(slug: "smash-masterclass"){
      id
      addrState
      city
      countryCode
      createdAt
      currency
      endAt
      eventRegistrationClosesAt
      events {
        id
        checkInBuffer
        checkInDuration
        checkInEnabled
        createdAt
        deckSubmissionDeadline
        entrants (query: {perPage: 500}) {
          nodes {
            id
            initialSeedNum
            isDisqualified
            name
            # event {id}
            # paginatedSets {}
            participants {
              checkedIn, 
              checkedInAt, 
              connectedAccounts, 
              #contactInfo {
              #	city,
              #	country,
              #	countryId,
              #	id,
              #	name, 
              #	nameFirst,
              #	nameLast,
              #	state,
              #	stateId,
              #	zipcode
              #}, 
              email, 
              # entrants {}
              # events {}
              gamerTag,
              id,
              # images(type: "") {url},
              # player
              prefix
              # user {}
              verified						
            }
          }
        }
      }
      hashtag
      hasOfflineEvents
      hasOnlineEvents
      id
      images(type: "") {
        url
        # more
      }
      isOnline
      isRegistrationOpen
      lat
      lng
      links {discord, facebook}
      mapsPlaceId
      name
      numAttendees
      owner {
        player {gamerTag},
        # more
      }
      # participants() {}
      postalCode,
      primaryContact,
      primaryContactType,
      publishing,
      registrationClosesAt,
      rules,
      shortSlug,
      slug,
      startAt,
      state,
      # stations() {},
      # streamQueue {},
      # streams {},
      teamCreationClosesAt,
      # teams {},
      timezone,
      tournamentType,
      updatedAt,
      url,
      venueAddress,
      venueName,
      # waves {},
    }
  }
  ''';
