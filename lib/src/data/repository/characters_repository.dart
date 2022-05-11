import 'package:casino_test/src/data/models/character_result.dart';

abstract class CharactersRepository {
  Future<CharacterResult?> getCharacters({String? nextUrl});
}
