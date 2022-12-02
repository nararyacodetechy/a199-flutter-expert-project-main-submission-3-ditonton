part of 'tv_bloc.dart';

abstract class TvEvent extends Equatable {
  const TvEvent();
  @override
  List<Object> get props => [];
}

class FetchAiringTodayTvs extends TvEvent {}

class FetchOnTheAirTvs extends TvEvent {}

class FetchPopularTvs extends TvEvent {}

class FetchTopRatedTvs extends TvEvent {}

class FetchDetailTvs extends TvEvent {
  final int id;
  const FetchDetailTvs(this.id);

  @override
  List<Object> get props => [id];
}

class FetchRecommendationTvs extends TvEvent {
  final int id;
  const FetchRecommendationTvs(this.id);

  @override
  List<Object> get props => [id];
}

class FetchWatchlistTvs extends TvEvent {}

class SaveWatchlistTv extends TvEvent {
  final TVDetail tv;

  const SaveWatchlistTv(this.tv);
  @override
  List<Object> get props => [tv];
}

class RemoveWatchlistTv extends TvEvent {
  final TVDetail tv;

  const RemoveWatchlistTv(this.tv);
  @override
  List<Object> get props => [tv];
}

class LoadWatchlistTvStatus extends TvEvent {
  final int id;
  const LoadWatchlistTvStatus(this.id);

  @override
  List<Object> get props => [id];
}
