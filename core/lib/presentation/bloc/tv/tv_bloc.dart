import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class AiringTodayTvsBloc extends Bloc<TvEvent, TvState> {
  final GetAiringTodayTvs _getAiringTodayTvs;

  AiringTodayTvsBloc(this._getAiringTodayTvs) : super(TvLoading()) {
    on<FetchAiringTodayTvs>((event, emit) async {
      emit(TvLoading());
      final result = await _getAiringTodayTvs.execute();
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tvs) {
        emit(TvHasData(tvs));
      });
    });
  }
}

class OnTheAirTvsBloc extends Bloc<TvEvent, TvState> {
  final GetOnTheAirTvs _getOnTheAirTvs;

  OnTheAirTvsBloc(this._getOnTheAirTvs) : super(TvLoading()) {
    on<FetchOnTheAirTvs>((event, emit) async {
      emit(TvLoading());
      final result = await _getOnTheAirTvs.execute();
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tvs) {
        emit(TvHasData(tvs));
      });
    });
  }
}

class PopularTvsBloc extends Bloc<TvEvent, TvState> {
  final GetPopularTvs _getPopularTvs;

  PopularTvsBloc(this._getPopularTvs) : super(TvLoading()) {
    on<FetchPopularTvs>((event, emit) async {
      emit(TvLoading());
      final result = await _getPopularTvs.execute();
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tvs) {
        emit(TvHasData(tvs));
      });
    });
  }
}

class TopRatedTvsBloc extends Bloc<TvEvent, TvState> {
  final GetTopRatedTvs _getTopRatedTvs;

  TopRatedTvsBloc(this._getTopRatedTvs) : super(TvLoading()) {
    on<FetchTopRatedTvs>((event, emit) async {
      emit(TvLoading());
      final result = await _getTopRatedTvs.execute();
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tvs) {
        emit(TvHasData(tvs));
      });
    });
  }
}

class DetailTvBloc extends Bloc<TvEvent, TvState> {
  final GetTvDetail _getTvDetail;
  DetailTvBloc(this._getTvDetail) : super(TvLoading()) {
    on<FetchDetailTvs>((event, emit) async {
      final id = event.id;
      emit(TvLoading());
      final result = await _getTvDetail.execute(id);
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (data) {
        emit(TvDetailHasData(data));
      });
    });
  }
}

class TvRecommendationBloc extends Bloc<TvEvent, TvState> {
  final GetTvRecommendations _getTvRecommendations;
  TvRecommendationBloc(this._getTvRecommendations) : super(TvLoading()) {
    on<FetchRecommendationTvs>((event, emit) async {
      final int id = event.id;
      emit(TvLoading());

      final result = await _getTvRecommendations.execute(id);
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tvs) {
        emit(TvHasData(tvs));
      });
    });
  }
}

class WatchlistTvBloc extends Bloc<TvEvent, TvState> {
  final GetWatchlistTvs _getWatchlistTvs;
  final GetWatchListTvStatus _getWatchListTvStatus;
  final SaveWatchlistTvs _saveWatchistTvs;
  final RemoveWatchlistTvs _removeWatchlistTvs;

  static const watchlistAddSuccessMessage = 'Added to Watchlist TV';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist TV';

  WatchlistTvBloc(this._getWatchlistTvs, this._getWatchListTvStatus,
      this._saveWatchistTvs, this._removeWatchlistTvs)
      : super(TvEmpty()) {
    on<FetchWatchlistTvs>((event, emit) async {
      emit(TvLoading());
      final result = await _getWatchlistTvs.execute();
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tvsData) {
        emit(WatchlistTvHasData(tvsData));
      });
    });

    on<SaveWatchlistTv>((event, emit) async {
      final tv = event.tv;
      emit(TvLoading());
      final result = await _saveWatchistTvs.execute(tv);

      result.fold(
        (failure) => emit(TvHasError(failure.message)),
        (data) => emit(
          WatchlistTvMessage(data),
        ),
      );
    });

    on<RemoveWatchlistTv>((event, emit) async {
      final tv = event.tv;
      emit(TvLoading());
      final result = await _removeWatchlistTvs.execute(tv);

      result.fold(
        (failure) => emit(TvHasError(failure.message)),
        (data) => emit(
          WatchlistTvMessage(data),
        ),
      );
    });

    on<LoadWatchlistTvStatus>((event, emit) async {
      final id = event.id;
      emit(TvLoading());
      final result = await _getWatchListTvStatus.execute(id);

      emit(LoadWatchlistTvData(result));
    });
  }
}
