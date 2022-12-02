// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import '../../../helpers/block_helper.dart';

void main() {
  late WatchlistMovieBlocHelper watchlistMovieBlocHelper;

  setUpAll(() {
    watchlistMovieBlocHelper = WatchlistMovieBlocHelper();
    registerFallbackValue(WatchlistMovieEventHelper());
    registerFallbackValue(WatchlistMovieStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistMovieBloc>(
            create: (_) => watchlistMovieBlocHelper),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should be show MovieCard List when Watchlist success loaded',
      (WidgetTester tester) async {
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(WatchlistMovieHasData(testMovieList));

    await tester.pumpWidget(
        _makeTestableWidget(const Material(child: WatchlistMoviesPage())));

    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('should be show CircularProgress when Watchlist loading',
      (WidgetTester tester) async {
    when(() => watchlistMovieBlocHelper.state).thenReturn(MovieLoading());

    await tester.pumpWidget(
        _makeTestableWidget(const Material(child: WatchlistMoviesPage())));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should be show text error when Watchlist error',
      (WidgetTester tester) async {
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(const MovieHasError('Failed'));

    await tester.pumpWidget(
        _makeTestableWidget(const Material(child: WatchlistMoviesPage())));

    expect(find.text('Failed'), findsOneWidget);
  });
}
