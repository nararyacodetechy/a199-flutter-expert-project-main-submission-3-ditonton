// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/search.dart';

class MockSearchBlocTv extends MockBloc<SearchEvent, SearchState>
    implements SearchBlocTv {}

class SearchStateFake extends Fake implements SearchState {}

class SearchEventFake extends Fake implements SearchEvent {}

void main() {
  group('search tv page', () {
    late MockSearchBlocTv mockSearchBlocTv;

    setUpAll(() {
      mockSearchBlocTv = MockSearchBlocTv();
      registerFallbackValue(SearchStateFake());
      registerFallbackValue(SearchEventFake());
    });

    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<SearchBlocTv>.value(
        value: mockSearchBlocTv,
        child: MaterialApp(
          home: Scaffold(body: body),
        ),
      );
    }

    tearDown(() {
      mockSearchBlocTv.close();
    });

    final tTv = TV(
      backdropPath: 'backdropPath',
      genreIds: const [1, 2, 3, 4],
      id: 1,
      originalName: 'originalName',
      originalLanguage: 'originalLanguange',
      overview: 'overview',
      popularity: 1.0,
      posterPath: 'posterPath',
      firstAirDate: 'firstAirDate',
      name: 'name',
      voteAverage: 1.0,
      voteCount: 1,
    );

    final List<TV> tListTv = [tTv];

    testWidgets('should be return List tvs when success', (tester) async {
      when(() => mockSearchBlocTv.state).thenReturn(SearchTvHasData(tListTv));
      await tester.pumpWidget(_makeTestableWidget(const SearchTvPage()));
      await tester.enterText(find.byType(TextField), 'Chucky');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.text('name'), findsWidgets);
    });

    testWidgets('should be return progress loading when loading',
        (tester) async {
      when(() => mockSearchBlocTv.state).thenReturn(SearchLoading());

      await tester.pumpWidget(_makeTestableWidget(const SearchTvPage()));

      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });
  });
}
