import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  final String name;
  final String image;
  final String status;
  final String species;
  final String gender;

  Character({
    required this.name,
    required this.image,
    required this.status,
    required this.species,
    required this.gender,
  });

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
