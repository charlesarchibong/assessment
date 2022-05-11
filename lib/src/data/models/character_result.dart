import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/models/info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character_result.g.dart';

@JsonSerializable(explicitToJson: true)
class CharacterResult {
  final List<Character>? results;
  final Info info;

  CharacterResult({
    required this.info,
    this.results,
  });

  factory CharacterResult.fromJson(Map<String, dynamic> json) => _$CharacterResultFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterResultToJson(this);

  CharacterResult copyWith({
    List<Character>? results,
    Info? info,
  }) {
    return CharacterResult(
      results: results ?? this.results,
      info: info ?? this.info,
    );
  }
}
