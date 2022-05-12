import 'package:bloc_test/bloc_test.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/models/character_result.dart';
import 'package:casino_test/src/data/models/info.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/bloc/main_event.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockMainPageBloc extends Mock implements MainPageBloc {}

class _MockCharactersRepository extends Mock implements CharactersRepository {}

void main() {
  late MainPageBloc mainPageBloc;
  late _MockCharactersRepository mockCharactersRepository;

  late CharacterResult characterResult;

  setUp(() {
    mockCharactersRepository = _MockCharactersRepository();
    mainPageBloc = MainPageBloc(InitialMainPageState(), mockCharactersRepository);
    characterResult = CharacterResult(
      info: Info(
        count: 1,
        next: null,
        pages: 42,
        prev: null,
      ),
      results: [
        Character(
          gender: 'Male',
          image: '',
          name: 'Charles',
          species: 'Robot',
          status: 'unknown',
        ),
        Character(
          gender: 'Male',
          image: '',
          name: 'Charles',
          species: 'Robot',
          status: 'unknown',
        ),
        Character(
          gender: 'Male',
          image: '',
          name: 'Charles',
          species: 'Robot',
          status: 'unknown',
        ),
      ],
    );
  });
  group('MainBlocTest', () {
    test('Should test stub states', () async {
      // Create a mock instance
      final counterBloc = _MockMainPageBloc();

      final listState = <MainPageState>[
        InitialMainPageState(),
        LoadingMainPageState(),
        UnSuccessfulMainPageState(),
        SuccessfulMainPageState(characterResult),
      ];

// Stub the state stream
      whenListen(
        counterBloc,
        Stream.fromIterable(listState),
        initialState: InitialMainPageState(),
      );

// Assert that the initial state is correct.
      expect(counterBloc.state, isA<InitialMainPageState>());

// Assert that the stubbed stream is emitted.
      await expectLater(counterBloc.stream, emitsInOrder(listState));

// Assert that the current state is in sync with the stubbed stream.
      expect(counterBloc.state, isA<SuccessfulMainPageState>());
    });

    test('initial state is correct', () {
      expect(mainPageBloc.state, isA<InitialMainPageState>());
    });

    blocTest(
      'emits loading and successful state when request is successful',
      build: () => mainPageBloc,
      setUp: () {
        when(mockCharactersRepository.getCharacters).thenAnswer(
          (_) => Future.value(characterResult),
        );
      },
      act: (MainPageBloc bloc) => bloc.add(GetTestDataOnMainPageEvent()),
      expect: () => [
        LoadingMainPageState(),
        SuccessfulMainPageState(characterResult),
      ],
    );

    blocTest(
      'emits unsuccessful state when request is unsuccessful',
      build: () => mainPageBloc,
      setUp: () {
        when(mockCharactersRepository.getCharacters).thenAnswer(
          (_) => Future.value(null),
        );
      },
      act: (MainPageBloc bloc) => bloc.add(GetTestDataOnMainPageEvent()),
      expect: () => [
        LoadingMainPageState(),
        UnSuccessfulMainPageState(),
      ],
    );
  });
}
