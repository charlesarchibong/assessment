import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/presentation/bloc/main_event.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final CharactersRepository _charactersRepository;

  MainPageBloc(
    MainPageState initialState,
    this._charactersRepository,
  ) : super(initialState) {
    on<GetTestDataOnMainPageEvent>(
      (event, emitter) => _getDataOnMainPageCasino(event, emitter),
    );
    on<DataLoadedOnMainPageEvent>(
      (event, emitter) => _dataLoadedOnMainPageCasino(event, emitter),
    );
    on<LoadingDataOnMainPageEvent>(
      (event, emitter) => emitter(LoadingMainPageState()),
    );
  }

  Future<void> _dataLoadedOnMainPageCasino(
    DataLoadedOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    if (event.characterResult != null) {
      if (state is SuccessfulMainPageState && event.characterResult != null) {
        final newCharacters = (state as SuccessfulMainPageState).characterResult.results ?? [];
        newCharacters.addAll(event.characterResult?.results ?? []);
        final newCharacterResult = event.characterResult!.copyWith(
          results: List<Character>.from(newCharacters),
        );
        emit(SuccessfulMainPageState(newCharacterResult));
      } else {
        emit(SuccessfulMainPageState(event.characterResult!));
      }
    } else {
      //This is to prvent the error when the data is loaded at first time (for pagination)
      if (!(state is SuccessfulMainPageState)) {
        emit(UnSuccessfulMainPageState());
      }
    }
  }

  Future<void> _getDataOnMainPageCasino(
    GetTestDataOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    //emit loading state only when page is initial
    if (event.url == null) {
      emit(LoadingMainPageState());
    }
    final result = await _charactersRepository.getCharacters(
      nextUrl: event.url,
    );
    add(DataLoadedOnMainPageEvent(result));
  }
}
