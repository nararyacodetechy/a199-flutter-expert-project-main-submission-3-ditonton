import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetPopularTvs {
  final TvRepository repository;

  GetPopularTvs(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getPopularTvs();
  }
}
