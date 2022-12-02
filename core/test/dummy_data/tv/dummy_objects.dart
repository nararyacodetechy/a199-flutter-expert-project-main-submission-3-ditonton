import 'package:core/core.dart';

final testTv = TV(
  backdropPath: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
  genreIds: const [80, 10765],
  id: 90462,
  originalName: "Chucky",
  originalLanguage: "en",
  overview:
      "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the towns hypocrisies and secrets. Meanwhile, the arrival of enemies and allies from Chuckys past threatens to expose the truth behind the killings, as well as the demon dolls untold origins.",
  popularity: 2380.124,
  posterPath: "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
  firstAirDate: "2021-10-12",
  name: "Chucky",
  voteAverage: 7.9,
  voteCount: 3437,
);

final testTvList = [testTv];

const testTvDetail = TVDetail(
  backdropPath: "backdropPath",
  genres: [Genre(id: 1, name: 'Animation')],
  homepage: "https://google.com",
  id: 1,
  originalLanguage: "en",
  originalName: "originalName",
  overview: "overview",
  popularity: 1,
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  status: 'status',
  tagline: 'tagline',
  name: 'name',
  inProduction: false,
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTv = TV.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);

const testTvTable = TVTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'name': 'name',
  'posterPath': 'posterPath',
  'overview': 'overview',
};
