// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      name: json['name'] as String,
      image: json['image'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'status': instance.status,
      'species': instance.species,
      'gender': instance.gender,
    };
