import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class TVDetail extends Equatable {
  const TVDetail({
    required this.backdropPath,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.status,
    required this.tagline,
    required this.name,
    required this.inProduction,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;

  final List<Genre> genres;
  final String firstAirDate;
  final String homepage;
  final int id;
  final bool inProduction;
  final String name;

  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;

  final String status;
  final String tagline;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        homepage,
        id,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        status,
        tagline,
        name,
        inProduction,
        voteAverage,
        voteCount,
      ];
}
