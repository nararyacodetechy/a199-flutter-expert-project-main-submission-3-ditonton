import 'package:core/core.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlistTv(TVTable tv);
  Future<String> removeWatchlistTv(TVTable tv);
  Future<TVTable?> getTvById(int id);
  Future<List<TVTable>> getWatchlistTvs();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelperTv databaseHelperTv;

  TvLocalDataSourceImpl({required this.databaseHelperTv});

  @override
  Future<String> insertWatchlistTv(TVTable tv) async {
    try {
      await databaseHelperTv.insertWatchListTv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(TVTable tv) async {
    try {
      await databaseHelperTv.removeWatchlistTv(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TVTable?> getTvById(int id) async {
    final result = await databaseHelperTv.getTvById(id);
    if (result != null) {
      return TVTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TVTable>> getWatchlistTvs() async {
    final result = await databaseHelperTv.getWatchlistTvs();
    return result.map((data) => TVTable.fromMap(data)).toList();
  }
}
