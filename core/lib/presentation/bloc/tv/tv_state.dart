part of 'tv_bloc.dart';

abstract class TvState extends Equatable {
  const TvState();

  @override
  List<Object> get props => [];
}

class TvLoading extends TvState {}

class TvEmpty extends TvState {}

class TvHasData extends TvState {
  final List<TV> tvs;

  const TvHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}

class TvHasError extends TvState {
  final String message;

  const TvHasError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailHasData extends TvState {
  final TVDetail tv;

  const TvDetailHasData(this.tv);

  @override
  List<Object> get props => [tv];
}

class WatchlistTvHasData extends TvState {
  final List<TV> tvs;

  const WatchlistTvHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}

class WatchlistTvMessage extends TvState {
  final String message;

  const WatchlistTvMessage(this.message);
}

class LoadWatchlistTvData extends TvState {
  final bool status;

  const LoadWatchlistTvData(this.status);

  @override
  List<Object> get props => [status];
}
