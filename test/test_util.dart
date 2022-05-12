import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';

import 'file_asset_bundle.dart';

Future<void> pumpYoloWidget(
  WidgetTester tester,
  Widget widget, {
  WidgetWrapper? wrapper,
  Size? surfaceSize,
  double textScaleSize = 1.0,
}) {
  return tester.pumpWidgetBuilder(
    DefaultAssetBundle(
      bundle: FileAssetBundle(),
      child: widget,
    ),
    wrapper: materialAppWrapper(),
  );
}

void whenBloc<State>(
  BlocBase<State> bloc,
  Stream<State> stream, {
  State? initialState,
}) {
  final broadcastStream = stream.asBroadcastStream();

  if (initialState != null) {
    when(() => bloc.state).thenReturn(initialState);
  }

  when(() => bloc.stream).thenAnswer(
    (_) => broadcastStream.map((state) {
      when(() => bloc.state).thenReturn(state);
      return state;
    }),
  );

  when(() => bloc.close()).thenAnswer((invocation) => Future.value());
}
