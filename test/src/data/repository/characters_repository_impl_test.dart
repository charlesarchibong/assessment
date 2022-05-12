import 'dart:convert';

import 'package:casino_test/src/data/models/character_result.dart';
import 'package:casino_test/src/data/repository/characters_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import 'sample_response.dart';

class _MockClient extends Mock implements Client {}

void main() {
  late _MockClient mockClient;
  late CharactersRepositoryImpl charactersRepository;
  setUp(() {
    mockClient = _MockClient();
    charactersRepository = CharactersRepositoryImpl(mockClient);
  });
  test('should return CharacterResult when API response is successful', () async {
    when(() => mockClient.get(Uri.parse('https://rickandmortyapi.com/api/character/?page=1'))).thenAnswer(
      (_) => Future.value(
        Response(json.encode(sampleResponse), 200),
      ),
    );

    final result = await charactersRepository.getCharacters();

    expect(result, isA<CharacterResult>());
  });
}
