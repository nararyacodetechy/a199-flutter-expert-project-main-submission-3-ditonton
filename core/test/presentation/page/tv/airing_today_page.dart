// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:core/core.dart';
import 'package:core/presentation/pages/tv/airing_today_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../dummy_data/tv/dummy_objects.dart';
import '../../../helpers/block_helper.dart';

void main() {
  late AiringTodayTvsBlocHelper airingTodayBlocHelper;
  setUpAll(() {
    airingTodayBlocHelper = AiringTodayTvsBlocHelper();
    registerFallbackValue(AiringTodayTvsStateHelper());
    registerFallbackValue(AiringTodayTvsEventHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<AiringTodayTvsBloc>(
      create: (_) => airingTodayBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    airingTodayBlocHelper.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => airingTodayBlocHelper.state).thenReturn(TvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const AiringTodayPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => airingTodayBlocHelper.state).thenReturn(TvLoading());
    when(() => airingTodayBlocHelper.state).thenReturn(TvHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const AiringTodayPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => airingTodayBlocHelper.state)
        .thenReturn(const TvHasError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const AiringTodayPage()));

    expect(textFinder, findsOneWidget);
  });
}
