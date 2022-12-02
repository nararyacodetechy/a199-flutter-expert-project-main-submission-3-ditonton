import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchlistMovies,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist
])
void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late PopularMoviesBloc popularMoviesBloc;
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late DetailMovieBloc detailMovieBloc;
  late MovieRecommendationBloc movieRecommendationBloc;
  late WatchlistMovieBloc watchlistMovieBloc;

  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveWatchlist mockRemoveWatchlistMovies;
  late MockSaveWatchlist mockSaveWatchlistMovies;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockSaveWatchlistMovies = MockSaveWatchlist();
    mockRemoveWatchlistMovies = MockRemoveWatchlist();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();

    nowPlayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
    topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
    movieRecommendationBloc =
        MovieRecommendationBloc(mockGetMovieRecommendations);
    detailMovieBloc = DetailMovieBloc(mockGetMovieDetail);
    watchlistMovieBloc = WatchlistMovieBloc(
        mockGetWatchlistMovies,
        mockGetWatchListStatus,
        mockSaveWatchlistMovies,
        mockRemoveWatchlistMovies);
  });
  final tMovie = Movie(
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

  final tMovieList = <Movie>[tMovie];

  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
    genres: [Genre(id: 1, name: 'name')],
  );

  const tId = 1;

  group('Get now playing movies', () {
    test('initial state must be empty', () {
      expect(nowPlayingMoviesBloc.state, MovieLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingMoviesBloc;
      },
      act: (NowPlayingMoviesBloc bloc) => bloc.add(FetchNowPlayingMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [MovieLoading(), MovieHasData(tMovieList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return nowPlayingMoviesBloc;
      },
      act: (NowPlayingMoviesBloc bloc) => bloc.add(FetchNowPlayingMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieLoading(),
        const MovieHasError('Server Failure'),
      ],
      verify: (NowPlayingMoviesBloc bloc) =>
          verify(mockGetNowPlayingMovies.execute()),
    );
  });

  group('Get Popular movies', () {
    test('initial state must be empty', () {
      expect(popularMoviesBloc.state, MovieLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularMoviesBloc;
      },
      act: (PopularMoviesBloc bloc) => bloc.add(FetchPopularMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [MovieLoading(), MovieHasData(tMovieList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return popularMoviesBloc;
      },
      act: (PopularMoviesBloc bloc) => bloc.add(FetchPopularMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieLoading(),
        const MovieHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetPopularMovies.execute()),
    );
  });

  group('Get Top Rated movies', () {
    test('initial state must be empty', () {
      expect(topRatedMoviesBloc.state, MovieLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedMoviesBloc;
      },
      act: (TopRatedMoviesBloc bloc) => bloc.add(FetchTopRatedMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [MovieLoading(), MovieHasData(tMovieList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return topRatedMoviesBloc;
      },
      act: (TopRatedMoviesBloc bloc) => bloc.add(FetchTopRatedMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieLoading(),
        const MovieHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTopRatedMovies.execute()),
    );
  });

  group('Get Recommended movies', () {
    test('initial state must be empty', () {
      expect(movieRecommendationBloc.state, MovieLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovieList));
        return movieRecommendationBloc;
      },
      act: (MovieRecommendationBloc bloc) =>
          bloc.add(const FetchRecommendationMovies(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [MovieLoading(), MovieHasData(tMovieList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return movieRecommendationBloc;
      },
      act: (MovieRecommendationBloc bloc) =>
          bloc.add(const FetchRecommendationMovies(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieLoading(),
        const MovieHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetMovieRecommendations.execute(tId)),
    );
  });

  group('Get Details movies', () {
    test('initial state must be empty', () {
      expect(detailMovieBloc.state, MovieLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(tMovieDetail));
        return detailMovieBloc;
      },
      act: (DetailMovieBloc bloc) => bloc.add(const FetchDetailMovies(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [MovieLoading(), const MovieDetailHasData(tMovieDetail)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return detailMovieBloc;
      },
      act: (DetailMovieBloc bloc) => bloc.add(const FetchDetailMovies(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieLoading(),
        const MovieHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetMovieDetail.execute(tId)),
    );
  });

  group('Get Watchlist movies', () {
    test('initial state must be empty', () {
      expect(watchlistMovieBloc.state, MovieEmpty());
    });

    group('Watchlist Movie', () {
      test('initial state should be empty', () {
        expect(watchlistMovieBloc.state, MovieEmpty());
      });

      group('Fetch Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockGetWatchlistMovies.execute())
                .thenAnswer((_) async => Right(tMovieList));
            return watchlistMovieBloc;
          },
          act: (WatchlistMovieBloc bloc) => bloc.add(FetchWatchlistMovies()),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            MovieLoading(),
            WatchlistMovieHasData(tMovieList),
          ],
          verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockGetWatchlistMovies.execute()).thenAnswer(
                (_) async => const Left(ServerFailure('Server Failure')));
            return watchlistMovieBloc;
          },
          act: (WatchlistMovieBloc bloc) => bloc.add(FetchWatchlistMovies()),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            MovieLoading(),
            const MovieHasError('Server Failure'),
          ],
          verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
        );
      });

      group('Load Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockGetWatchListStatus.execute(tId))
                .thenAnswer((_) async => true);
            return watchlistMovieBloc;
          },
          act: (WatchlistMovieBloc bloc) =>
              bloc.add(const LoadWatchlistMovieStatus(tId)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            MovieLoading(),
            const LoadWatchlistData(true),
          ],
          verify: (bloc) => verify(mockGetWatchListStatus.execute(tId)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockGetWatchListStatus.execute(tId))
                .thenAnswer((_) async => false);
            return watchlistMovieBloc;
          },
          act: (WatchlistMovieBloc bloc) =>
              bloc.add(const LoadWatchlistMovieStatus(tId)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            MovieLoading(),
            const LoadWatchlistData(false),
          ],
          verify: (bloc) => verify(mockGetWatchListStatus.execute(tId)),
        );
      });

      group('Save Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockSaveWatchlistMovies.execute(tMovieDetail)).thenAnswer(
                (_) async =>
                    const Right(WatchlistMovieBloc.watchlistAddSuccessMessage));
            return watchlistMovieBloc;
          },
          act: (WatchlistMovieBloc bloc) =>
              bloc.add(const SaveWatchlistMovies(tMovieDetail)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            MovieLoading(),
            const WatchlistMovieMessage(
                WatchlistMovieBloc.watchlistAddSuccessMessage),
          ],
          verify: (bloc) =>
              verify(mockSaveWatchlistMovies.execute(tMovieDetail)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockSaveWatchlistMovies.execute(tMovieDetail)).thenAnswer(
                (_) async => const Left(ServerFailure('Server Failure')));
            return watchlistMovieBloc;
          },
          act: (WatchlistMovieBloc bloc) =>
              bloc.add(const SaveWatchlistMovies(tMovieDetail)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            MovieLoading(),
            const MovieHasError('Server Failure'),
          ],
          verify: (bloc) =>
              verify(mockSaveWatchlistMovies.execute(tMovieDetail)),
        );
      });

      group('Remove Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockRemoveWatchlistMovies.execute(tMovieDetail)).thenAnswer(
                (_) async =>
                    const Right(WatchlistMovieBloc.watchlistAddSuccessMessage));
            return watchlistMovieBloc;
          },
          act: (WatchlistMovieBloc bloc) =>
              bloc.add(const RemoveWatchlistMovies(tMovieDetail)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            MovieLoading(),
            const WatchlistMovieMessage(
                WatchlistMovieBloc.watchlistAddSuccessMessage),
          ],
          verify: (bloc) =>
              verify(mockRemoveWatchlistMovies.execute(tMovieDetail)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockRemoveWatchlistMovies.execute(tMovieDetail)).thenAnswer(
                (_) async => const Left(ServerFailure('Server Failure')));
            return watchlistMovieBloc;
          },
          act: (WatchlistMovieBloc bloc) =>
              bloc.add(const RemoveWatchlistMovies(tMovieDetail)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            MovieLoading(),
            const MovieHasError('Server Failure'),
          ],
          verify: (bloc) =>
              verify(mockRemoveWatchlistMovies.execute(tMovieDetail)),
        );
      });
    });
  });
}
