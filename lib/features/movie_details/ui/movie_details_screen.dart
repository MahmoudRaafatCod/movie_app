import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie/core/constants/extensions/assets.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';
import 'package:movie/core/routing/route_names.dart';
import 'package:movie/features/home_screen/logic/app_bar_scroll/app_bar_scroll_cubit.dart';
import 'package:movie/features/movie_details/data/models/saved_movie_model.dart';
import 'package:movie/features/movie_details/logic/caste_details/caste_details_cubit.dart';
import 'package:movie/features/movie_details/logic/more_like_this/similar_cubit.dart';
import 'package:movie/features/movie_details/logic/movie_details/movie_details_cubit.dart';
import 'package:movie/features/movie_details/logic/review/review_cubit.dart';
import 'package:movie/features/movie_details/logic/tap_text/tap_cubit.dart';
import 'package:movie/features/movie_details/logic/trailer/trailer_cubit.dart';
import 'package:movie/features/movie_details/ui/widget/movie_review.dart';
import 'package:movie/features/movie_details/ui/widget/movie_similar.dart';
import 'package:movie/features/movie_details/ui/widget/text_row.dart';
import 'package:movie/features/movie_details/ui/widget/trailers_widget.dart';
import 'package:movie/features/my_list/logic/saved_movies/saved_movies_cubit.dart';
import 'package:readmore/readmore.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int movieId = ModalRoute.of(context)!.settings.arguments as int;
    final ScrollController scrollController = ScrollController();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MovieDetailsCubit(movieId)),
        BlocProvider(create: (context) => CasteDetailsCubit(movieId , "movie")),
        BlocProvider(create: (context) => TapCubit()),
        BlocProvider(create: (context) => TrailerCubit(movieId , "movie")),
        BlocProvider(create: (context) => SimilarCubit(movieId , "movie")),
        BlocProvider(create: (context) => AppBarScrollCubit()),
        BlocProvider(create: (context) => ReviewCubit(movieId ,"movie")),
      ],
      child: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsSuccess) {
            scrollController.addListener(() {
              context.read<AppBarScrollCubit>().updateOffset(
                scrollController.offset,
              );
            });

            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: BlocBuilder<AppBarScrollCubit, double>(
                  builder: (context, opacity) {
                    return AppBar(
                      backgroundColor: context.appBarColor.withValues(alpha: opacity),
                      elevation: 0,
                      actions: [
                        IconButton(onPressed: ()=>Navigator.pushNamed(context, RouteNames.search.name), icon: Icon(Icons.search))
                      ],
                    );
                  },
                ),
              ),
              body: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Container(
                      height: 350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "${Assets.baseUrl}${state.movie.posterPath}",
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  state.movie.title,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                    icon: SvgPicture.asset( context.watch<SavedMoviesCubit>().isSaved(movieId) ? 'assets/icons/Bookmark2.svg' : 'assets/icons/Bookmark.svg', width: 20, height: 20,),
                                    onPressed: () {
                                      context.read<SavedMoviesCubit>().toggleMovie(
                                        SavedMovieModel(
                                          id: movieId,
                                          title: state.movie.title,
                                          mediaType: "movie",
                                          posterPath: state.movie.posterPath,
                                          voteAverage: state.movie.voteAverage,
                                        ),
                                      );
                                    },
                                  )
                            ],
                          ),
                          SizedBox(height: 10),

                          Row(
                            children: [
                              Icon(
                                Icons.star_half,
                                color: context.primaryColor,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text(
                                state.movie.voteAverage.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: context.primaryColor,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: context.primaryColor,
                                size: 15,
                              ),
                              SizedBox(width: 8),
                              Text("${state.movie.releaseDate.year}"),
                            ],
                          ),
                          SizedBox(height: 10),

                          Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: state.movie.genres.map((genre) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: context.primaryColor.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: context.primaryColor.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  genre.name,
                                  style: TextStyle(
                                    color: context.primaryColor,
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 20),

                          Text(
                            "Overview",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          ReadMoreText(
                            state.movie.overview,
                            trimLines: 4,
                            trimMode: TrimMode.Line,
                            style: TextStyle(fontSize: 12),
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            moreStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: context.primaryColor,
                            ),
                            lessStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: context.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 20),

                          Text(
                            "Cast",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          BlocBuilder<CasteDetailsCubit, CasteDetailsState>(
                            builder: (context, state) {
                              if (state is CasteDetailsSuccess) {
                                return SizedBox(
                                  height: 100,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.cast.length,
                                    itemBuilder: (context, index) {
                                      final cast = state.cast[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context, RouteNames.actorDetails.name, arguments: cast.id);

                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 10,
                                          ),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundImage: NetworkImage(
                                                  cast.profilePath != null
                                                      ? "${Assets.baseUrl}${cast.profilePath}"
                                                      : Assets.errorImage,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    cast.name,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    cast.knownForDepartment,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (_, _) {
                                      return SizedBox(width: 10);
                                    },
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 20),

                          BlocBuilder<TapCubit, int>(
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  TextRow(text: "Trailer", isOnTap: state == 0, onTap: () => context.read<TapCubit>().selectTab(0),),
                                  TextRow(text: "More Like This", isOnTap: state == 1, onTap: () => context.read<TapCubit>().selectTab(1),),
                                  TextRow(text: "Comments", isOnTap: state == 2, onTap: () => context.read<TapCubit>().selectTab(2),),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 25),

                          SizedBox(
                            height: 550,
                            child: BlocBuilder<TapCubit, int>(
                              builder: (context, selectedIndex) {
                                if (selectedIndex == 0) {
                                  return TrailersWidget();
                                } else if (selectedIndex == 1) {
                                  return MovieSimilar();
                                } else {
                                  return MovieReview();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
