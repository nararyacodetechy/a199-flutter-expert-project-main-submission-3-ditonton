import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class NowPlayingMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies) : super(MovieLoading()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(MovieLoading());
      final result = await _getNowPlayingMovies.execute();
      result.fold((failure) {
        emit(MovieHasError(failure.message));
      }, (movies) {
        emit(MovieHasData(movies));
      });
    });
  }
}

class PopularMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(MovieLoading()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(MovieLoading());
      final result = await _getPopularMovies.execute();
      result.fold((failure) {
        emit(MovieHasError(failure.message));
      }, (movies) {
        emit(MovieHasData(movies));
      });
    });
  }
}

class TopRatedMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(MovieLoading()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(MovieLoading());
      final result = await _getTopRatedMovies.execute();
      result.fold((failure) {
        emit(MovieHasError(failure.message));
      }, (movies) {
        emit(MovieHasData(movies));
      });
    });
  }
}

class DetailMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetail _getMovieDetail;
  DetailMovieBloc(this._getMovieDetail) : super(MovieLoading()) {
    on<FetchDetailMovies>((event, emit) async {
      final id = event.id;
      emit(MovieLoading());
      final result = await _getMovieDetail.execute(id);
      result.fold((failure) {
        emit(MovieHasError(failure.message));
      }, (data) {
        emit(MovieDetailHasData(data));
      });
    });
  }
}

class MovieRecommendationBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieRecommendations _getMovieRecommendations;
  MovieRecommendationBloc(this._getMovieRecommendations)
      : super(MovieLoading()) {
    on<FetchRecommendationMovies>((event, emit) async {
      final int id = event.id;
      emit(MovieLoading());

      final result = await _getMovieRecommendations.execute(id);
      result.fold((failure) {
        emit(MovieHasError(failure.message));
      }, (movies) {
        emit(MovieHasData(movies));
      });
    });
  }
}

class WatchlistMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist Movie';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist Movie';

  WatchlistMovieBloc(this._getWatchlistMovies, this._getWatchListStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(MovieEmpty()) {
    on<FetchWatchlistMovies>((event, emit) async {
      emit(MovieLoading());
      final result = await _getWatchlistMovies.execute();
      result.fold((failure) {
        emit(MovieHasError(failure.message));
      }, (moviesData) {
        emit(WatchlistMovieHasData(moviesData));
      });
    });

    on<SaveWatchlistMovies>((event, emit) async {
      final movie = event.movie;
      emit(MovieLoading());
      final result = await _saveWatchlist.execute(movie);

      result.fold(
        (failure) => emit(MovieHasError(failure.message)),
        (data) => emit(
          WatchlistMovieMessage(data),
        ),
      );
    });

    on<RemoveWatchlistMovies>((event, emit) async {
      final movie = event.movie;
      emit(MovieLoading());
      final result = await _removeWatchlist.execute(movie);

      result.fold(
        (failure) => emit(MovieHasError(failure.message)),
        (data) => emit(
          WatchlistMovieMessage(data),
        ),
      );
    });

    on<LoadWatchlistMovieStatus>((event, emit) async {
      final id = event.id;
      emit(MovieLoading());
      final result = await _getWatchListStatus.execute(id);

      emit(LoadWatchlistData(result));
    });
  }
}
