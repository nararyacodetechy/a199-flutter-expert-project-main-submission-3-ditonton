// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/search.dart';

class MockSearchBlocMovie extends MockBloc<SearchEvent, SearchState>
    implements SearchBlocMovie {}

class SearchStateFake extends Fake implements SearchState {}

class SearchEventFake extends Fake implements SearchEvent {}

void main() {
  group('search movie page', () {
    late MockSearchBlocMovie mockSearchBlocMovie;

    setUpAll(() {
      mockSearchBlocMovie = MockSearchBlocMovie();
      registerFallbackValue(SearchStateFake());
      registerFallbackValue(SearchEventFake());
    });

    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<SearchBlocMovie>.value(
        value: mockSearchBlocMovie,
        child: MaterialApp(
          home: Scaffold(body: body),
        ),
      );
    }

    tearDown(() {
      mockSearchBlocMovie.close();
    });

    final tMovie = Movie(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: const [1, 2, 3, 4],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1.0,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      title: 'title',
      video: false,
      voteAverage: 1.0,
      voteCount: 1,
    );

    final List<Movie> tListMovie = [tMovie];

    testWidgets('should be return List Movies when success', (tester) async {
      when(() => mockSearchBlocMovie.state)
          .thenReturn(SearchMovieHasData(tListMovie));
      await tester.pumpWidget(_makeTestableWidget(const SearchPage()));
      await tester.enterText(find.byType(TextField), 'spiderman');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.text('title'), findsWidgets);
    });

    testWidgets('should be return progress loading when loading',
        (tester) async {
      when(() => mockSearchBlocMovie.state).thenReturn(SearchLoading());

      await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });
  });
}
