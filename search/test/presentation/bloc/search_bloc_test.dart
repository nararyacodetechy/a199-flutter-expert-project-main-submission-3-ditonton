import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTvs])
void main() {
  late SearchBlocMovie searchBloc;
  late MockSearchMovies mockSearchMovies;

  late SearchBlocTv searchBlocTv;
  late MockSearchTvs mockSearchTvs;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchBloc = SearchBlocMovie(mockSearchMovies);
  });

  setUp(() {
    mockSearchTvs = MockSearchTvs();
    searchBlocTv = SearchBlocTv(mockSearchTvs);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
  });

  test('initial state should be empty', () {
    expect(searchBlocTv.state, SearchEmpty());
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  final tTvModel = TV(
      backdropPath: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
      genreIds: const [80, 10765],
      id: 90462,
      originalName: "Chucky",
      originalLanguage: "en",
      overview:
          "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the towns hypocrisies and secrets. Meanwhile, the arrival of enemies and allies from Chuckys past threatens to expose the truth behind the killings, as well as the demon dolls untold origins.",
      popularity: 2380.124,
      posterPath: "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
      firstAirDate: "2021-10-12",
      name: "Chucky",
      voteAverage: 7.9,
      voteCount: 3437);

  final tTvList = <TV>[tTvModel];
  const tQuerytv = 'Chucky';

  blocTest<SearchBlocMovie, SearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnMovieQueryChanged(query: tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchMovieHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<SearchBlocMovie, SearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnMovieQueryChanged(query: tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      const SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<SearchBlocTv, SearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvs.execute(tQuerytv))
          .thenAnswer((_) async => Right(tTvList));
      return searchBlocTv;
    },
    act: (bloc) => bloc.add(const OnTvQueryChanged(query: tQuerytv)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchTvHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuerytv));
    },
  );

  blocTest<SearchBlocTv, SearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvs.execute(tQuerytv))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchBlocTv;
    },
    act: (bloc) => bloc.add(const OnTvQueryChanged(query: tQuerytv)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      const SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuerytv));
    },
  );
}
