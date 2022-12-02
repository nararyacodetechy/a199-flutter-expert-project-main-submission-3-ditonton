import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class TvRepository {
  Future<Either<Failure, List<TV>>> getAiringTodayTvs();
  Future<Either<Failure, List<TV>>> getOnTheAirTvs();
  Future<Either<Failure, List<TV>>> getPopularTvs();
  Future<Either<Failure, List<TV>>> getTopRatedTvs();
  Future<Either<Failure, TVDetail>> getTvDetail(int id);
  Future<Either<Failure, List<TV>>> getTvRecommendations(int id);
  Future<Either<Failure, List<TV>>> searchTvs(String query);
  Future<Either<Failure, String>> saveWatchlistTv(TVDetail tv);
  Future<Either<Failure, String>> removeWatchlistTv(TVDetail tv);
  Future<bool> isAddedToWatchlistTv(int id);
  Future<Either<Failure, List<TV>>> getWatchlistTvs();
}
