import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class SearchTvs {
  final TvRepository repository;

  SearchTvs(this.repository);

  Future<Either<Failure, List<TV>>> execute(String query) {
    return repository.searchTvs(query);
  }
}
