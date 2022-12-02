import 'package:core/core.dart';

class GetWatchListTvStatus {
  final TvRepository repository;

  GetWatchListTvStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTv(id);
  }
}
