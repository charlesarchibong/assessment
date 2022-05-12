import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/models/character_result.dart';
import 'package:casino_test/src/data/models/info.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:casino_test/src/presentation/ui/character_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_util.dart';

class _MockCharactersRepository extends Mock implements CharactersRepository {}

void main() {
  //Test golden using "flutter test --update-goldens"
  group('MainScreen', () {
    testGoldens('character_screen_initial', (tester) async {
      final MainPageState state = InitialMainPageState();
      final mainPageBloc = MainPageBloc(state, _MockCharactersRepository());

      await tester.pumpCharacterScreen(mainPageBloc);

      await multiScreenGolden(
        tester,
        'character_screen_initial',
        autoHeight: true,
      );
    });

    testGoldens('character_screen_loading', (tester) async {
      final MainPageState state = LoadingMainPageState();
      final mainPageBloc = MainPageBloc(state, _MockCharactersRepository());

      await tester.pumpCharacterScreen(mainPageBloc);

      await multiScreenGolden(
        tester,
        'character_screen_loading',
        autoHeight: true,
      );
    });

    testGoldens('character_screen_unsuccessful', (tester) async {
      final MainPageState state = UnSuccessfulMainPageState();
      final mainPageBloc = MainPageBloc(state, _MockCharactersRepository());

      await tester.pumpCharacterScreen(mainPageBloc);

      await multiScreenGolden(
        tester,
        'character_screen_unsuccessful',
        autoHeight: true,
      );
    });
    testGoldens('character_screen_successful', (tester) async {
      final MainPageState state = SuccessfulMainPageState(
        CharacterResult(
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
        ),
      );
      final mainPageBloc = MainPageBloc(state, _MockCharactersRepository());

      await tester.pumpCharacterScreen(mainPageBloc);

      await multiScreenGolden(
        tester,
        'character_screen_successful',
        autoHeight: true,
      );
    });
  });
}

extension on WidgetTester {
  Future<void> pumpCharacterScreen(MainPageBloc mainPageBloc) {
    return pumpYoloWidget(
      this,
      BlocProvider<MainPageBloc>.value(
        value: mainPageBloc,
        child: CharacterWidget(),
      ),
    );
  }
}
