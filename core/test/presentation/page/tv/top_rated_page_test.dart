// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../dummy_data/tv/dummy_objects.dart';
import '../../../helpers/block_helper.dart';

void main() {
  late TopRatedTvsBlocHelper topRatedTvsBlocHelper;
  setUpAll(() {
    topRatedTvsBlocHelper = TopRatedTvsBlocHelper();
    registerFallbackValue(TopRatedTvsStateHelper());
    registerFallbackValue(TopRatedTvsEventHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvsBloc>(
      create: (_) => topRatedTvsBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    topRatedTvsBlocHelper.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => topRatedTvsBlocHelper.state).thenReturn(TvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvsPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => topRatedTvsBlocHelper.state).thenReturn(TvLoading());
    when(() => topRatedTvsBlocHelper.state).thenReturn(TvHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => topRatedTvsBlocHelper.state)
        .thenReturn(const TvHasError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
