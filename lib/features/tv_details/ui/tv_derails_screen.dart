import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie/core/constants/extensions/assets.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';
import 'package:movie/core/routing/app_route_names.dart';
import 'package:movie/features/home_screen/logic/app_bar_scroll/app_bar_scroll_cubit.dart';
import 'package:movie/features/movie_details/data/models/saved_movie_model.dart';
import 'package:movie/features/movie_details/logic/caste_details/caste_details_cubit.dart';
import 'package:movie/features/movie_details/logic/tap_text/tap_cubit.dart';
import 'package:movie/features/movie_details/ui/widget/movie_review.dart';
import 'package:movie/features/movie_details/ui/widget/movie_similar.dart';
import 'package:movie/features/movie_details/ui/widget/text_row.dart';
import 'package:movie/features/movie_details/ui/widget/trailers_widget.dart';
import 'package:movie/features/my_list/logic/saved_movies/saved_movies_cubit.dart';
import 'package:movie/features/tv_details/logic/tv_details/tv_details_cubit.dart';
import 'package:movie/features/tv_details/logic/tv_details/tv_details_state.dart';
import 'package:movie/features/tv_details/logic/tv_season_details/tv_season_cubit.dart';
import 'package:readmore/readmore.dart';

class TvDerailsScreen extends StatelessWidget {
  const TvDerailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return  BlocBuilder<TvDetailsCubit, TvDetailsState>(
        builder: (context, seasonState) {
          if (seasonState is TvDetailsSuccess) {
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
                        IconButton(onPressed: ()=>Navigator.pushNamed(context, AppRouteNames.search), icon: Icon(Icons.search))
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
                            "${Assets.baseUrl}${seasonState.tvShow.posterPath}",
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
                                  seasonState.tvShow.name,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: SvgPicture.asset( context.watch<SavedMoviesCubit>().isSaved(context.read<CasteDetailsCubit>().movieId) ? 'assets/icons/Bookmark2.svg' : 'assets/icons/Bookmark.svg', width: 20, height: 20,),
                                onPressed: () {
                                  context.read<SavedMoviesCubit>().toggleMovie(
                                    SavedMovieModel(
                                      id: context.read<CasteDetailsCubit>().movieId,
                                      title: seasonState.tvShow.name,
                                      mediaType: "tv",
                                      posterPath: seasonState.tvShow.posterPath!,
                                      voteAverage: seasonState.tvShow.voteAverage,
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
                                seasonState.tvShow.voteAverage.toStringAsFixed(1),
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
                              Text("${seasonState.tvShow.firstAirDate?.year}"),
                            ],
                          ),
                          SizedBox(height: 10),

                          Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: seasonState.tvShow.genres.map((genre) {
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

                          Text("Overview", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                          SizedBox(height: 10),
                          ReadMoreText(
                            seasonState.tvShow.overview,
                            trimLines: 3,
                            trimMode: TrimMode.Line,
                            style: TextStyle(fontSize: 12),
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            moreStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: context.primaryColor,
                            ),
                            lessStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: context.primaryColor,),
                          ),
                          const SizedBox(height: 20),

                          Text("Cast", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),

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
                                          Navigator.pushNamed(context, AppRouteNames.actorDetails, arguments: cast.id);
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
                                                  Text(cast.name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,),),
                                                  SizedBox(height: 5),
                                                  Text(cast.knownForDepartment, style: TextStyle(fontSize: 10,),),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Episodes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                              DropdownButton<int>(
                                value: context.watch<TvDetailsCubit>().selectedSeason,
                                underline: const SizedBox(),
                                dropdownColor: context.appBarColor,
                                style: TextStyle(
                                  color: context.primaryColor, fontSize: 16,),
                                items: seasonState.tvShow.seasons.map((season) {
                                  return DropdownMenuItem(
                                    value: season.seasonNumber,
                                    child: Text("Season ${season.seasonNumber}" ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  context.read<TvDetailsCubit>().selectSeason(value!);
                                  context.read<TvSeasonCubit>().selectSeason(value);

                                },
                              ),
                            ],
                          ),

                          SizedBox(height: 20,),

                          BlocBuilder<TvSeasonCubit, TvSeasonState>(
                            builder: (context, state) {
                              if (state is TvSeasonSuccess) {
                                return SizedBox(
                                  height: 200,
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (_ , index) {
                                        final episode = state.data.episodes[index];
                                        return GestureDetector(
                                          onTap: (){
                                            Navigator.pushNamed(context, AppRouteNames.tvEpisodeDetails, arguments: {"tvShowId" : context.read<CasteDetailsCubit>().movieId , "seasonNumber" : episode.seasonNumber , "episodeNumber" : episode.episodeNumber},);
                                          },
                                          child: SizedBox(
                                            width: 250,
                                            child: AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      episode.stillPath != null
                                                          ? "${Assets.baseUrl}${episode.stillPath}"
                                                          : "${Assets.baseUrl}${seasonState.tvShow.posterPath}",
                                                    ),
                                                    fit: BoxFit.cover,
                                                    colorFilter: const ColorFilter.mode(
                                                      Colors.black12,
                                                      BlendMode.darken,
                                                    ),
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Align(alignment: Alignment.center, child: Icon(Icons.play_circle , color: Colors.white54, size: 40,)),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10),
                                                      child: Align(alignment: Alignment.bottomLeft, child: Text("Episode ${episode.episodeNumber} : ${episode.name}", style: TextStyle(color: Colors.white, fontSize: 13),)),
                                                    )

                                                  ]
                                                )
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (_, _) {
                                        return SizedBox(width: 10);
                                      },
                                      itemCount: state.data.episodes.length),
                                );
                              } else if(state is TvSeasonError) {
                                return Center(child: Text(state.message));
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),


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
                                  return MovieSimilar(isTV: true,);
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

    );
  }
}
