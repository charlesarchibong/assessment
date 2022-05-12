import 'dart:async';
import 'dart:convert';

import 'package:casino_test/src/data/models/character_result.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:http/http.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final Client client;

  CharactersRepositoryImpl(this.client);

  @override
  Future<CharacterResult?> getCharacters({String? nextUrl}) async {
    try {
      final uri = Uri.parse(nextUrl ?? 'https://rickandmortyapi.com/api/character/?page=1');
      final charResult = await client.get(uri);
      final jsonMap = await json.decode(charResult.body) as Map<String, dynamic>;
      return CharacterResult.fromJson(jsonMap);
    } catch (e) {
      return null;
    }
  }
}
