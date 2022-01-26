// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tournament _$TournamentFromJson(Map<String, dynamic> json) => Tournament(
      id: json['id'] as String,
      name: json['name'] as String,
      numAttendees: json['numAttendees'] as String,
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
      url: json['url'] as String,
      slug: json['slug'] as String,
      city: json['city'] as String,
      hasOfflineEvents: json['hasOfflineEvents'] as bool,
      hasOnlineEvents: json['hasOnlineEvents'] as bool,
      isOnline: json['isOnline'] as bool,
      imageUrl: json['imageUrl'] as String,
      bannerUrl: json['bannerUrl'] as String,
      bannerWidth: json['bannerWidth'] as int,
      bannerHeight: json['bannerHeight'] as int,
    );

Map<String, dynamic> _$TournamentToJson(Tournament instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'isOnline': instance.isOnline,
      'imageUrl': instance.imageUrl,
      'bannerUrl': instance.bannerUrl,
      'bannerWidth': instance.bannerWidth,
      'bannerHeight': instance.bannerHeight,
      'numAttendees': instance.numAttendees,
      'startAt': instance.startAt.toIso8601String(),
      'endAt': instance.endAt.toIso8601String(),
      'url': instance.url,
      'city': instance.city,
      'hasOfflineEvents': instance.hasOfflineEvents,
      'hasOnlineEvents': instance.hasOnlineEvents,
    };
