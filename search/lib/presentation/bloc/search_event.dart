part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnMovieQueryChanged extends SearchEvent {
  final String query;
  const OnMovieQueryChanged({required this.query});

  @override
  List<Object> get props => [query];
}

class OnTvQueryChanged extends SearchEvent {
  final String query;
  const OnTvQueryChanged({required this.query});

  @override
  List<Object> get props => [query];
}
