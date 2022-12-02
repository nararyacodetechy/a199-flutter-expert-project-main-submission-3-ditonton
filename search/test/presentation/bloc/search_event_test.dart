import 'package:flutter_test/flutter_test.dart';
import 'package:search/search.dart';

void main() {
  testWidgets('search event', (tester) async {
    expect(
        const OnMovieQueryChanged(query: 'test') !=
            const OnMovieQueryChanged(query: 'search'),
        true);
  });
}
