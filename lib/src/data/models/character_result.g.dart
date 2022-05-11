// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterResult _$CharacterResultFromJson(Map<String, dynamic> json) =>
    CharacterResult(
      info: Info.fromJson(json['info'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CharacterResultToJson(CharacterResult instance) =>
    <String, dynamic>{
      'results': instance.results?.map((e) => e.toJson()).toList(),
      'info': instance.info.toJson(),
    };
