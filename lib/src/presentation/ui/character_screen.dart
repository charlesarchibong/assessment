import 'dart:developer';

import 'package:casino_test/core/test/test_util.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/bloc/main_event.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:casino_test/src/presentation/ui/widget/safe_image.dart';
import 'package:casino_test/src/presentation/ui/widget/safe_progress_indication_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@immutable
class CharactersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainPageBloc(
        InitialMainPageState(),
        GetIt.I.get<CharactersRepository>(),
      )..add(const GetTestDataOnMainPageEvent()),
      child: CharacterWidget(),
    );
  }
}

class CharacterWidget extends StatefulWidget {
  const CharacterWidget({Key? key}) : super(key: key);

  @override
  State<CharacterWidget> createState() => _CharacterWidgetState();
}

class _CharacterWidgetState extends State<CharacterWidget> {
  late final ScrollController _scrollController;

  void _scrollingListener() {
    if (_scrollController.offset >= (_scrollController.position.maxScrollExtent - 200)) {
      final mainPageState = context.read<MainPageBloc>().state;
      if (mainPageState is SuccessfulMainPageState && mainPageState.characterResult.info.next != null) {
        log("fetching new data");
        context.read<MainPageBloc>().add(
              GetTestDataOnMainPageEvent(
                url: mainPageState.characterResult.info.next,
              ),
            );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollingListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MainPageBloc, MainPageState>(
        builder: (blocContext, state) {
          if (state is LoadingMainPageState) {
            return _loadingWidget(context);
          } else if (state is SuccessfulMainPageState) {
            return _successfulWidget(context, state);
          } else if (state is UnSuccessfulMainPageState) {
            return const Center(
              child: Text("error"),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _loadingWidget(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        child: SafeProgressIndicatorFactory.adaptive(),
      ),
    );
  }

  Widget _successfulWidget(BuildContext context, SuccessfulMainPageState state) {
    return ListView.builder(
      itemCount: state.characterResult.results!.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        return _characterWidget(context, state.characterResult.results![index]);
      },
    );
  }

  Widget _characterWidget(BuildContext context, Character character) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: Color.fromARGB(120, 204, 255, 255),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeImage(
                  url: TestUtil.isTest ? null : character.image,
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(character.name),
                    Text(character.species),
                    Text(character.gender),
                  ],
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
