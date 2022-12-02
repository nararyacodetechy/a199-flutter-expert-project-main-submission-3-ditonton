// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../dummy_data/tv/dummy_objects.dart';
import '../../../helpers/block_helper.dart';

void main() {
  late OnTheAirTvsBlocHelper onTheAirTvsBlocHelper;
  setUpAll(() {
    onTheAirTvsBlocHelper = OnTheAirTvsBlocHelper();
    registerFallbackValue(OnTheAirTvsStateHelper());
    registerFallbackValue(OnTheAirTvsEventHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<OnTheAirTvsBloc>(
      create: (_) => onTheAirTvsBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    onTheAirTvsBlocHelper.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => onTheAirTvsBlocHelper.state).thenReturn(TvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const OnTheAirTvsPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => onTheAirTvsBlocHelper.state).thenReturn(TvLoading());
    when(() => onTheAirTvsBlocHelper.state).thenReturn(TvHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const OnTheAirTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => onTheAirTvsBlocHelper.state)
        .thenReturn(const TvHasError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const OnTheAirTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
