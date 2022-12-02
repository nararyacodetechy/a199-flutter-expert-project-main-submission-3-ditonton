import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetWatchlistTvs {
  final TvRepository _repository;

  GetWatchlistTvs(this._repository);

  Future<Either<Failure, List<TV>>> execute() {
    return _repository.getWatchlistTvs();
  }
}
