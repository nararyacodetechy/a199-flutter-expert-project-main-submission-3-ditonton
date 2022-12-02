part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {}

class MovieEmpty extends MovieState {}

class MovieHasData extends MovieState {
  final List<Movie> movies;

  const MovieHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieHasError extends MovieState {
  final String message;

  const MovieHasError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieState {
  final MovieDetail movie;

  const MovieDetailHasData(this.movie);

  @override
  List<Object> get props => [movie];
}

class WatchlistMovieHasData extends MovieState {
  final List<Movie> movies;

  const WatchlistMovieHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class WatchlistMovieMessage extends MovieState {
  final String message;

  const WatchlistMovieMessage(this.message);
}

class LoadWatchlistData extends MovieState {
  final bool status;

  const LoadWatchlistData(this.status);

  @override
  List<Object> get props => [status];
}
