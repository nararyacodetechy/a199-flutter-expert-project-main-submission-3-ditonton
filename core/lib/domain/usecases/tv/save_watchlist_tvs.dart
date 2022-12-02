import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class SaveWatchlistTvs {
  final TvRepository repository;

  SaveWatchlistTvs(this.repository);

  Future<Either<Failure, String>> execute(TVDetail tv) {
    return repository.saveWatchlistTv(tv);
  }
}
