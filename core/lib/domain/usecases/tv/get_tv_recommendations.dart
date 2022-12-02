import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<TV>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
