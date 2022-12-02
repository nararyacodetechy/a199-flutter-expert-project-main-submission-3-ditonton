import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetOnTheAirTvs {
  final TvRepository repository;

  GetOnTheAirTvs(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getOnTheAirTvs();
  }
}
