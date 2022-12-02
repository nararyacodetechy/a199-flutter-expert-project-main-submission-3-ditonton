import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTopRatedTvs {
  final TvRepository repository;

  GetTopRatedTvs(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getTopRatedTvs();
  }
}
