import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class RemoveWatchlistTvs {
  final TvRepository repository;

  RemoveWatchlistTvs(this.repository);

  Future<Either<Failure, String>> execute(TVDetail tv) {
    return repository.removeWatchlistTv(tv);
  }
}
