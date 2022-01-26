import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tournament.g.dart';

@JsonSerializable()
class Tournament extends Equatable {
  final String id;
  final String name;
  final String slug;
  final bool isOnline;
  final String imageUrl;
  final String bannerUrl;
  final int bannerWidth;
  final int bannerHeight;
  final String numAttendees;
  final DateTime startAt;
  final DateTime endAt;
  final String url;
  final String city;
  final bool hasOfflineEvents;
  final bool hasOnlineEvents;

  const Tournament({
    required this.id,
    required this.name,
    required this.numAttendees,
    required this.startAt,
    required this.endAt,
    required this.url,
    required this.slug,
    required this.city,
    required this.hasOfflineEvents,
    required this.hasOnlineEvents,
    required this.isOnline,
    required this.imageUrl,
    required this.bannerUrl,
    required this.bannerWidth,
    required this.bannerHeight,
  });

  factory Tournament.fromMap(Map<String, dynamic> map) {
    var startTime = map["startAt"] * 1000;
    var endTime = map["endAt"] * 1000;

    String imageUrlTemp = '';
    String bannerUrlTemp = '';
    int bannerHeightTemp = 1;
    int bannerWidthTemp = 1;

    for (var entry in map["images"]) {
      if (entry["type"] == "profile") {
        imageUrlTemp = entry["url"];
      }
      if (entry["type"] == "banner") {
        bannerUrlTemp = entry["url"];
        bannerHeightTemp = entry["height"] ?? 1;
        bannerWidthTemp = entry["width"] ?? 1;
      }
    }

    return Tournament(
      id: map["id"].toString(),
      name: map["name"].toString(),
      slug: map["slug"].toString(),
      numAttendees: (map["numAttendees"] ?? 0).toString(),
      startAt: DateTime.fromMillisecondsSinceEpoch(startTime),
      endAt: DateTime.fromMillisecondsSinceEpoch(endTime),
      url: map["url"].toString(),
      city: map["city"].toString(),
      hasOfflineEvents: map["hasOfflineEvents"] ?? false,
      hasOnlineEvents: map["hasOnlineEvents"] ?? false,
      isOnline: map["isOnline"],
      imageUrl: imageUrlTemp.toString(),
      bannerUrl: bannerUrlTemp.toString(),
      bannerWidth: bannerWidthTemp,
      bannerHeight: bannerHeightTemp,
    );
  }

  factory Tournament.fromJson(Map<String, dynamic> json) => _$TournamentFromJson(json);
  Map<String, dynamic> toJson(Tournament t) => _$TournamentToJson(t);

  @override
  List<Object?> get props => [
        id,
        name,
        numAttendees,
        startAt,
        endAt,
        url,
        slug,
        city,
        hasOfflineEvents,
        hasOnlineEvents,
      ];
}
