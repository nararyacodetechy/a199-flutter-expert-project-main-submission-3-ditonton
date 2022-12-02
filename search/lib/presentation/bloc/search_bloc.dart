import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/search.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBlocMovie extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;

  SearchBlocMovie(this._searchMovies) : super(SearchEmpty()) {
    on<OnMovieQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());
        final result = await _searchMovies.execute(query);

        result.fold((failure) {
          emit(SearchError(failure.message));
        }, (data) {
          emit(SearchMovieHasData(data));
        });
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}

class SearchBlocTv extends Bloc<SearchEvent, SearchState> {
  final SearchTvs _searchTvs;

  SearchBlocTv(this._searchTvs) : super(SearchEmpty()) {
    on<OnTvQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());
        final result = await _searchTvs.execute(query);

        result.fold((failure) {
          emit(SearchError(failure.message));
        }, (data) {
          emit(SearchTvHasData(data));
        });
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
