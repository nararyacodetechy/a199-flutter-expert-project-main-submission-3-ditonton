import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // arrange
  const tGenreModel = GenreModel(
    id: 1,
    name: 'name',
  );

  final tGenreModelJson = {
    "id": 1,
    "name": 'name',
  };

  const tGenre = Genre(
    id: 1,
    name: 'name',
  );

  group('genre model test', () {
    test('should convert toJson', () {
      // assert
      final result = tGenreModel.toJson();
      // act
      expect(result, tGenreModelJson);
    });

    test('should convert toModel', () {
      // assert
      final result = GenreModel.fromJson(tGenreModelJson);
      // act
      expect(result, tGenreModel);
    });

    test('should convert toEntity', () {
      // assert
      final result = tGenreModel.toEntity();
      // act
      expect(result, tGenre);
    });
  });
}
