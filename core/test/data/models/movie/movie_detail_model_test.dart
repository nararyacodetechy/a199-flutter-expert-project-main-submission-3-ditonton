import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // arrange
  const tMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 1,
    genres: [],
    homepage: 'homepage',
    id: 1,
    imdbId: 'imdbId',
    originalLanguage: 'originalLanguage',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    revenue: 1,
    runtime: 1,
    status: 'status',
    tagline: 'tagline',
    title: 'title',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tMovieDetailResponseJson = {
    "adult": false,
    "backdrop_path": 'backdropPath',
    "budget": 1,
    "genres": [],
    "homepage": 'homepage',
    "id": 1,
    "imdb_id": 'imdbId',
    "original_language": 'originalLanguage',
    "original_title": 'originalTitle',
    "overview": 'overview',
    "popularity": 1.0,
    "poster_path": 'posterPath',
    "release_date": 'releaseDate',
    "revenue": 1,
    "runtime": 1,
    "status": 'status',
    "tagline": 'tagline',
    "title": 'title',
    "video": false,
    "vote_average": 1.0,
    "vote_count": 1,
  };

  test('should be json form MovieDetailResponse', () async {
    // assert
    final result = tMovieDetailResponse.toJson();
    // act
    expect(result, tMovieDetailResponseJson);
  });
}
