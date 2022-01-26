import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String id;
  final String slug;
  final String tournamentId;
  final String tournamentSlug;
  final String tournamentName;
  final String name;
  final String state;
  final String numEntrants;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime startAt;
  final bool isOnline;

  const Event({
    required this.id,
    required this.slug,
    required this.tournamentId,
    required this.tournamentSlug,
    required this.tournamentName,
    required this.name,
    required this.state,
    required this.numEntrants,
    required this.createdAt,
    required this.updatedAt,
    required this.startAt,
    required this.isOnline,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    map["createdAt"] = map["createdAt"] * 1000;
    map["updatedAt"] = map["updatedAt"] * 1000;
    map["startAt"] = map["startAt"] * 1000;
    
    return Event(
      id: map["id"].toString(),
      slug: map["slug"],
      name: map["name"],
      tournamentId: map["tournament"]["id"].toString(),
      tournamentSlug: map["tournament"]["slug"],
      tournamentName: map["tournament"]["name"],
      state: map["state"],
      numEntrants: (map["numEntrants"] ?? 0).toString(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map["createdAt"]),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map["updatedAt"]),
      startAt: DateTime.fromMillisecondsSinceEpoch(map["startAt"]),
      isOnline: map["isOnline"],
    );
  }

  @override
  List<Object?> get props => [
        id,
        slug,
        tournamentId,
        tournamentSlug,
        tournamentName,
        name,
        state,
        numEntrants,
        createdAt,
        updatedAt,
        startAt,
        isOnline,
      ];
}
