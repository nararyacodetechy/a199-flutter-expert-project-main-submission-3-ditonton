import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTvDetail {
  final TvRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TVDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
