// ignore_for_file: constant_identifier_names, library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  const TvDetailPage({super.key, required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailTvBloc>().add(FetchDetailTvs(widget.id));
      context
          .read<TvRecommendationBloc>()
          .add(FetchRecommendationTvs(widget.id));
    });
    context.read<WatchlistTvBloc>().add(LoadWatchlistTvStatus(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final recommendationTvs =
        context.select<TvRecommendationBloc, List<TV>>((value) {
      var state = value.state;
      if (state is TvHasData) {
        return (state).tvs;
      }
      return [];
    });

    var isAddedToTvWatchlist = context.select<WatchlistTvBloc, bool>((value) {
      var state = value.state;
      if (state is LoadWatchlistTvData) {
        return state.status;
      }
      return false;
    });
    return Scaffold(
      body: BlocBuilder<DetailTvBloc, TvState>(
        builder: (context, state) {
          if (state is TvLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailHasData) {
            return SafeArea(
              child: DetailContentTv(
                state.tv,
                recommendationTvs,
                isAddedToTvWatchlist,
              ),
            );
          } else if (state is TvHasError) {
            return Text(state.message);
          } else {
            return const Text('Failed');
          }
        },
      ),
    );
  }
}

class DetailContentTv extends StatelessWidget {
  final TVDetail tv;
  final List<TV> recommendations;
  final bool isAddedWatchlist;

  const DetailContentTv(this.tv, this.recommendations, this.isAddedWatchlist,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tv.name,
                                style: kHeading5,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (!isAddedWatchlist) {
                                    context
                                        .read<WatchlistTvBloc>()
                                        .add(SaveWatchlistTv(tv));
                                  } else {
                                    context
                                        .read<WatchlistTvBloc>()
                                        .add(RemoveWatchlistTv(tv));
                                  }

                                  String message = '';

                                  final state =
                                      BlocProvider.of<WatchlistTvBloc>(context)
                                          .state;

                                  if (state is LoadWatchlistTvData) {
                                    message = isAddedWatchlist
                                        ? WatchlistTvBloc
                                            .watchlistRemoveSuccessMessage
                                        : WatchlistTvBloc
                                            .watchlistAddSuccessMessage;
                                  } else {
                                    message = isAddedWatchlist == false
                                        ? WatchlistTvBloc
                                            .watchlistAddSuccessMessage
                                        : WatchlistTvBloc
                                            .watchlistRemoveSuccessMessage;
                                  }

                                  if (message ==
                                          WatchlistTvBloc
                                              .watchlistAddSuccessMessage ||
                                      message ==
                                          WatchlistTvBloc
                                              .watchlistRemoveSuccessMessage) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            content: Text(message)));
                                    BlocProvider.of<WatchlistTvBloc>(context)
                                        .add(LoadWatchlistTvStatus(tv.id));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(message),
                                          );
                                        });
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    isAddedWatchlist
                                        ? const Icon(Icons.check)
                                        : const Icon(Icons.add),
                                    const Text('Watchlist'),
                                  ],
                                ),
                              ),
                              Text(
                                _showGenres(tv.genres),
                              ),
                              Text(
                                tv.firstAirDate,
                              ),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: tv.voteAverage / 2,
                                    itemCount: 5,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: kMikadoYellow,
                                    ),
                                    itemSize: 24,
                                  ),
                                  Text('${tv.voteAverage}')
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Overview',
                                style: kHeading6,
                              ),
                              Text(
                                tv.overview,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Recommendations',
                                style: kHeading6,
                              ),
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final tv = recommendations[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                            context,
                                            TvDetailPage.ROUTE_NAME,
                                            arguments: tv.id,
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                            placeholder: (context, url) =>
                                                const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: recommendations.length,
                                ),
                              ),
                            ],
                          ),
                        )),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
