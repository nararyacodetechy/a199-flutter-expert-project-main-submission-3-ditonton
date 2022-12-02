part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
  @override
  List<Object> get props => [];
}

class FetchNowPlayingMovies extends MovieEvent {}

class FetchPopularMovies extends MovieEvent {}

class FetchTopRatedMovies extends MovieEvent {}

class FetchDetailMovies extends MovieEvent {
  final int id;
  const FetchDetailMovies(this.id);

  @override
  List<Object> get props => [id];
}

class FetchRecommendationMovies extends MovieEvent {
  final int id;
  const FetchRecommendationMovies(this.id);

  @override
  List<Object> get props => [id];
}

class FetchWatchlistMovies extends MovieEvent {}

class SaveWatchlistMovies extends MovieEvent {
  final MovieDetail movie;

  const SaveWatchlistMovies(this.movie);
  @override
  List<Object> get props => [movie];
}

class RemoveWatchlistMovies extends MovieEvent {
  final MovieDetail movie;

  const RemoveWatchlistMovies(this.movie);
  @override
  List<Object> get props => [movie];
}

class LoadWatchlistMovieStatus extends MovieEvent {
  final int id;
  const LoadWatchlistMovieStatus(this.id);

  @override
  List<Object> get props => [id];
}
