// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import '../../../helpers/block_helper.dart';

void main() {
  late DetailMovieBlocHelper detailMovieBlocHelper;
  late MovieRecommendationBlocHelper movieRecommendationBlocHelper;
  late WatchlistMovieBlocHelper watchlistMovieBlocHelper;

  setUpAll(() {
    detailMovieBlocHelper = DetailMovieBlocHelper();
    registerFallbackValue(MovieDetailEventHelper());
    registerFallbackValue(MovieDetailStateHelper());

    movieRecommendationBlocHelper = MovieRecommendationBlocHelper();
    registerFallbackValue(MovieRecommendationEventHelper());
    registerFallbackValue(MovieRecommendationStateHelper());

    watchlistMovieBlocHelper = WatchlistMovieBlocHelper();
    registerFallbackValue(WatchlistMovieEventHelper());
    registerFallbackValue(WatchlistMovieStateHelper());
    registerFallbackValue(PopularMoviesEventHelper());
    registerFallbackValue(PopularMoviesStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailMovieBloc>(create: (_) => detailMovieBlocHelper),
        BlocProvider<WatchlistMovieBloc>(
          create: (_) => watchlistMovieBlocHelper,
        ),
        BlocProvider<MovieRecommendationBloc>(
          create: (_) => movieRecommendationBlocHelper,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => detailMovieBlocHelper.state).thenReturn(MovieLoading());
    when(() => watchlistMovieBlocHelper.state).thenReturn(MovieLoading());
    when(() => movieRecommendationBlocHelper.state).thenReturn(MovieLoading());

    final circularProgress = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(
      id: 1,
    )));
    await tester.pump();

    expect(circularProgress, findsOneWidget);
  });
  testWidgets(
      'Watchlist button should display + icon when movie not added to watch list',
      (WidgetTester tester) async {
    when(() => detailMovieBlocHelper.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => movieRecommendationBlocHelper.state)
        .thenReturn(MovieHasData(testMovieList));
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(const LoadWatchlistData(false));

    final watchListButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 97080)));
    await tester.pump();
    expect(watchListButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie added to watch list',
      (WidgetTester tester) async {
    when(() => detailMovieBlocHelper.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));

    when(() => movieRecommendationBlocHelper.state)
        .thenReturn(MovieHasData(testMovieList));
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(const LoadWatchlistData(true));

    final watchListButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 97080)));
    expect(watchListButtonIcon, findsOneWidget);
  });
}
