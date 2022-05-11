import 'package:casino_test/src/data/models/character_result.dart';
import 'package:equatable/equatable.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object?> get props => [];
}

class GetTestDataOnMainPageEvent extends MainPageEvent {
  final String? url;

  const GetTestDataOnMainPageEvent({this.url});

  @override
  List<Object?> get props => [url];
}

class LoadingDataOnMainPageEvent extends MainPageEvent {
  const LoadingDataOnMainPageEvent();

  @override
  List<Object?> get props => [];
}

class DataLoadedOnMainPageEvent extends MainPageEvent {
  final CharacterResult? characterResult;

  const DataLoadedOnMainPageEvent(this.characterResult);

  @override
  List<Object?> get props => [characterResult];
}
