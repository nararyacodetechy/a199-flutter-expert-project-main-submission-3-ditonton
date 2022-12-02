import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetAiringTodayTvs,
  GetOnTheAirTvs,
  GetPopularTvs,
  GetTopRatedTvs,
  GetTvDetail,
  GetTvRecommendations,
  GetWatchlistTvs,
  GetWatchListTvStatus,
  SaveWatchlistTvs,
  RemoveWatchlistTvs
])
void main() {
  late AiringTodayTvsBloc airingTodayTvsBloc;
  late OnTheAirTvsBloc onTheAirTvsBloc;
  late PopularTvsBloc popularTvsBloc;
  late TopRatedTvsBloc topRatedTvsBloc;
  late DetailTvBloc detailTvBloc;
  late TvRecommendationBloc tvRecommendationBloc;
  late WatchlistTvBloc watchlistTvBloc;

  late MockGetAiringTodayTvs mockGetAiringTodayTvs;
  late MockGetOnTheAirTvs mockGetOnTheAirTvs;
  late MockGetPopularTvs mockGetPopularTvs;
  late MockGetTopRatedTvs mockGetTopRatedTvs;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchlistTvs mockGetWatchlistTvs;
  late MockGetWatchListTvStatus mockGetWatchlistTvStatus;
  late MockSaveWatchlistTvs mockSaveWatchlistTvs;
  late MockRemoveWatchlistTvs mockRemoveWatchlistTvs;

  setUp(() {
    mockGetAiringTodayTvs = MockGetAiringTodayTvs();
    mockGetOnTheAirTvs = MockGetOnTheAirTvs();
    mockGetPopularTvs = MockGetPopularTvs();
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    mockSaveWatchlistTvs = MockSaveWatchlistTvs();
    mockRemoveWatchlistTvs = MockRemoveWatchlistTvs();
    mockGetWatchlistTvStatus = MockGetWatchListTvStatus();

    airingTodayTvsBloc = AiringTodayTvsBloc(mockGetAiringTodayTvs);
    onTheAirTvsBloc = OnTheAirTvsBloc(mockGetOnTheAirTvs);
    popularTvsBloc = PopularTvsBloc(mockGetPopularTvs);
    topRatedTvsBloc = TopRatedTvsBloc(mockGetTopRatedTvs);
    detailTvBloc = DetailTvBloc(mockGetTvDetail);
    tvRecommendationBloc = TvRecommendationBloc(mockGetTvRecommendations);
    watchlistTvBloc = WatchlistTvBloc(mockGetWatchlistTvs,
        mockGetWatchlistTvStatus, mockSaveWatchlistTvs, mockRemoveWatchlistTvs);
  });

  final tTv = TV(
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

  final tTvList = <TV>[tTv];

  const tTvDetail = TVDetail(
    backdropPath: "backdropPath",
    genres: [Genre(id: 1, name: 'Animation')],
    homepage: "https://google.com",
    id: 1,
    originalLanguage: "en",
    originalName: "originalName",
    overview: "overview",
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    status: 'status',
    tagline: 'tagline',
    name: 'name',
    inProduction: false,
    voteAverage: 1,
    voteCount: 1,
  );
  const tId = 1;

  group('Get now playing tvs', () {
    test('initial state must be empty', () {
      expect(airingTodayTvsBloc.state, TvLoading());
    });

    blocTest(
      'should emit[loading, TvHasData] when data is gotten succesfully',
      build: () {
        when(mockGetAiringTodayTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return airingTodayTvsBloc;
      },
      act: (AiringTodayTvsBloc bloc) => bloc.add(FetchAiringTodayTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvLoading(), TvHasData(tTvList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetAiringTodayTvs.execute()).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return airingTodayTvsBloc;
      },
      act: (AiringTodayTvsBloc bloc) => bloc.add(FetchAiringTodayTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        const TvHasError('Server Failure'),
      ],
      verify: (AiringTodayTvsBloc bloc) =>
          verify(mockGetAiringTodayTvs.execute()),
    );
  });

  group('Get On The Air tvs', () {
    test('initial state must be empty', () {
      expect(onTheAirTvsBloc.state, TvLoading());
    });

    blocTest(
      'should emit[loading, TvHasData] when data is gotten succesfully',
      build: () {
        when(mockGetOnTheAirTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return onTheAirTvsBloc;
      },
      act: (OnTheAirTvsBloc bloc) => bloc.add(FetchOnTheAirTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvLoading(), TvHasData(tTvList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetOnTheAirTvs.execute()).thenAnswer((realInvocation) async =>
            const Left(ServerFailure('Server Failure')));
        return onTheAirTvsBloc;
      },
      act: (OnTheAirTvsBloc bloc) => bloc.add(FetchOnTheAirTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        const TvHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetOnTheAirTvs.execute()),
    );
  });

  group('Get Popular tvs', () {
    test('initial state must be empty', () {
      expect(popularTvsBloc.state, TvLoading());
    });

    blocTest(
      'should emit[loading, TvHasData] when data is gotten succesfully',
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return popularTvsBloc;
      },
      act: (PopularTvsBloc bloc) => bloc.add(FetchPopularTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvLoading(), TvHasData(tTvList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetPopularTvs.execute()).thenAnswer((realInvocation) async =>
            const Left(ServerFailure('Server Failure')));
        return popularTvsBloc;
      },
      act: (PopularTvsBloc bloc) => bloc.add(FetchPopularTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        const TvHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetPopularTvs.execute()),
    );
  });

  group('Get Top Rated Tvs', () {
    test('initial state must be empty', () {
      expect(topRatedTvsBloc.state, TvLoading());
    });

    blocTest(
      'should emit[loading, TvHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return topRatedTvsBloc;
      },
      act: (TopRatedTvsBloc bloc) => bloc.add(FetchTopRatedTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvLoading(), TvHasData(tTvList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTopRatedTvs.execute()).thenAnswer((realInvocation) async =>
            const Left(ServerFailure('Server Failure')));
        return topRatedTvsBloc;
      },
      act: (TopRatedTvsBloc bloc) => bloc.add(FetchTopRatedTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        const TvHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTopRatedTvs.execute()),
    );
  });

  group('Get Recommended tvs', () {
    test('initial state must be empty', () {
      expect(tvRecommendationBloc.state, TvLoading());
    });

    blocTest(
      'should emit[loading, TvHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvList));
        return tvRecommendationBloc;
      },
      act: (TvRecommendationBloc bloc) =>
          bloc.add(const FetchRecommendationTvs(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvLoading(), TvHasData(tTvList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvRecommendations.execute(tId)).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return tvRecommendationBloc;
      },
      act: (TvRecommendationBloc bloc) =>
          bloc.add(const FetchRecommendationTvs(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        const TvHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTvRecommendations.execute(tId)),
    );
  });

  group('Get Details tvs', () {
    test('initial state must be empty', () {
      expect(detailTvBloc.state, TvLoading());
    });

    blocTest(
      'should emit[loading, TvHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => const Right(tTvDetail));
        return detailTvBloc;
      },
      act: (DetailTvBloc bloc) => bloc.add(const FetchDetailTvs(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvLoading(), const TvDetailHasData(tTvDetail)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvDetail.execute(tId)).thenAnswer((realInvocation) async =>
            const Left(ServerFailure('Server Failure')));
        return detailTvBloc;
      },
      act: (DetailTvBloc bloc) => bloc.add(const FetchDetailTvs(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        const TvHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTvDetail.execute(tId)),
    );
  });

  group('Get Watchlist Tvs', () {
    test('initial state must be empty', () {
      expect(watchlistTvBloc.state, TvEmpty());
    });

    group('Watchlist Tv', () {
      test('initial state should be empty', () {
        expect(watchlistTvBloc.state, TvEmpty());
      });

      group('Fetch Watchlist Tv', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockGetWatchlistTvs.execute())
                .thenAnswer((_) async => Right(tTvList));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) => bloc.add(FetchWatchlistTvs()),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            WatchlistTvHasData(tTvList),
          ],
          verify: (bloc) => verify(mockGetWatchlistTvs.execute()),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockGetWatchlistTvs.execute()).thenAnswer(
                (_) async => const Left(ServerFailure('Server Failure')));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) => bloc.add(FetchWatchlistTvs()),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            const TvHasError('Server Failure'),
          ],
          verify: (bloc) => verify(mockGetWatchlistTvs.execute()),
        );
      });

      group('Load Watchlist Tv', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockGetWatchlistTvStatus.execute(tId))
                .thenAnswer((_) async => true);
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) =>
              bloc.add(const LoadWatchlistTvStatus(tId)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            const LoadWatchlistTvData(true),
          ],
          verify: (bloc) => verify(mockGetWatchlistTvStatus.execute(tId)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockGetWatchlistTvStatus.execute(tId))
                .thenAnswer((_) async => false);
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) =>
              bloc.add(const LoadWatchlistTvStatus(tId)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            const LoadWatchlistTvData(false),
          ],
          verify: (bloc) => verify(mockGetWatchlistTvStatus.execute(tId)),
        );
      });

      group('Save Watchlist Tv', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockSaveWatchlistTvs.execute(tTvDetail)).thenAnswer(
                (_) async =>
                    const Right(WatchlistTvBloc.watchlistAddSuccessMessage));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) =>
              bloc.add(const SaveWatchlistTv(tTvDetail)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            const WatchlistTvMessage(
                WatchlistTvBloc.watchlistAddSuccessMessage),
          ],
          verify: (bloc) => verify(mockSaveWatchlistTvs.execute(tTvDetail)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockSaveWatchlistTvs.execute(tTvDetail)).thenAnswer(
                (_) async => const Left(ServerFailure('Server Failure')));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) =>
              bloc.add(const SaveWatchlistTv(tTvDetail)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            const TvHasError('Server Failure'),
          ],
          verify: (bloc) => verify(mockSaveWatchlistTvs.execute(tTvDetail)),
        );
      });

      group('Remove Watchlist Tv', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockRemoveWatchlistTvs.execute(tTvDetail)).thenAnswer(
                (_) async =>
                    const Right(WatchlistTvBloc.watchlistAddSuccessMessage));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) =>
              bloc.add(const RemoveWatchlistTv(tTvDetail)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            const WatchlistTvMessage(
                WatchlistTvBloc.watchlistAddSuccessMessage),
          ],
          verify: (bloc) => verify(mockRemoveWatchlistTvs.execute(tTvDetail)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockRemoveWatchlistTvs.execute(tTvDetail)).thenAnswer(
                (_) async => const Left(ServerFailure('Server Failure')));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) =>
              bloc.add(const RemoveWatchlistTv(tTvDetail)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            const TvHasError('Server Failure'),
          ],
          verify: (bloc) => verify(mockRemoveWatchlistTvs.execute(tTvDetail)),
        );
      });
    });
  });
}
