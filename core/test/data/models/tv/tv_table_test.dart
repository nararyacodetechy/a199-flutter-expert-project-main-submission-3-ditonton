import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvTable = TVTable(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  final tTvTableJson = {
    'id': 1,
    'name': 'name',
    'posterPath': 'posterPath',
    'overview': 'overview'
  };

  test('should be json from TvTable', () async {
    // assert
    final result = tTvTable.toJson();
    // act
    expect(result, tTvTableJson);
  });
}
