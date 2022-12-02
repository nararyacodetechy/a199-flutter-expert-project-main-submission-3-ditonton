import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // arrange
  const tTVDetailResponse = TVDetailResponse(
    backdropPath: 'backdropPath',
    genres: [],
    homepage: 'homepage',
    id: 1,
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    status: 'status',
    tagline: 'tagline',
    name: 'name',
    inProduction: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTVDetailResponseJson = {
    'backdrop_path': 'backdropPath',
    'genres': [],
    'homepage': 'homepage',
    'id': 1,
    'original_language': 'originalLanguage',
    'original_name': 'originalName',
    'overview': 'overview',
    'popularity': 1.0,
    'poster_path': 'posterPath',
    'first_air_date': 'firstAirDate',
    'status': 'status',
    'tagline': 'tagline',
    'name': 'name',
    'in_production': false,
    'vote_average': 1.0,
    'vote_count': 1,
  };

  test('should be json form TVDEtailResponse', () async {
    // assert
    final result = tTVDetailResponse.toJson();
    // act
    expect(result, tTVDetailResponseJson);
  });
}
