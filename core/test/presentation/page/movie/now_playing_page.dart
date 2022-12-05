// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:core/core.dart';
import 'package:core/presentation/pages/movie/now_playing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import '../../../helpers/block_helper.dart';

void main() {
  late NowPlayingMoviesBlocHelper nowPlayingBlocHelper;
  setUpAll(() {
    nowPlayingBlocHelper = NowPlayingMoviesBlocHelper();
    registerFallbackValue(NowPlayingMoviesStateHelper());
    registerFallbackValue(NowPlayingMoviesEventHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingMoviesBloc>(
      create: (_) => nowPlayingBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    nowPlayingBlocHelper.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => nowPlayingBlocHelper.state).thenReturn(MovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const NowPlayingPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => nowPlayingBlocHelper.state).thenReturn(MovieLoading());
    when(() => nowPlayingBlocHelper.state)
        .thenReturn(MovieHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const NowPlayingPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => nowPlayingBlocHelper.state)
        .thenReturn(const MovieHasError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const NowPlayingPage()));

    expect(textFinder, findsOneWidget);
  });
}
