// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/tv/dummy_objects.dart';
import '../../../helpers/block_helper.dart';

void main() {
  late WatchlistTvBlocHelper watchlistTvBlocHelper;

  setUpAll(() {
    watchlistTvBlocHelper = WatchlistTvBlocHelper();
    registerFallbackValue(WatchlistTvEventHelper());
    registerFallbackValue(WatchlistTvStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistTvBloc>(create: (_) => watchlistTvBlocHelper),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should be show TvCard List when Watchlist success loaded',
      (WidgetTester tester) async {
    when(() => watchlistTvBlocHelper.state)
        .thenReturn(WatchlistTvHasData(testTvList));

    await tester.pumpWidget(
        _makeTestableWidget(const Material(child: WatchlistTvsPage())));

    expect(find.byType(TvCard), findsOneWidget);
  });

  testWidgets('should be show CircularProgress when Watchlist loading',
      (WidgetTester tester) async {
    when(() => watchlistTvBlocHelper.state).thenReturn(TvLoading());

    await tester.pumpWidget(
        _makeTestableWidget(const Material(child: WatchlistTvsPage())));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should be show text error when Watchlist error',
      (WidgetTester tester) async {
    when(() => watchlistTvBlocHelper.state)
        .thenReturn(const TvHasError('Failed'));

    await tester.pumpWidget(
        _makeTestableWidget(const Material(child: WatchlistTvsPage())));

    expect(find.text('Failed'), findsOneWidget);
  });
}
