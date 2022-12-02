import 'dart:convert';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../json_reader.dart';

void main() {
  const tTvModel = TVModel(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalName: "original name",
    originalLanguage: "en",
    overview: "overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    firstAirDate: "2020-05-05",
    name: "name",
    voteAverage: 1.0,
    voteCount: 1,
  );
  const tTvResponseModel = TVResponse(tvList: <TVModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv/tv_airing_today.json'));
      // act
      final result = TVResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });
}
