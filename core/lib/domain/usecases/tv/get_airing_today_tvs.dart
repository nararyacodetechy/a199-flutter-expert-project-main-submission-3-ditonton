import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetAiringTodayTvs {
  final TvRepository repository;

  GetAiringTodayTvs(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getAiringTodayTvs();
  }
}
