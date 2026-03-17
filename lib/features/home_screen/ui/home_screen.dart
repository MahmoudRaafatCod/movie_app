import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constants/extensions/assets.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';
import 'package:movie/core/routing/app_route_names.dart';
import 'package:movie/core/routing/route_names.dart';
import 'package:movie/features/home_screen/logic/app_bar_scroll/app_bar_scroll_cubit.dart';
import 'package:movie/features/home_screen/logic/now_playing/now_playing_cubit.dart';
import 'package:movie/features/home_screen/logic/on_the_air_tv/on_the_air_cubit.dart';
import 'package:movie/features/home_screen/logic/popular_tv/popular_tv_cubit.dart';
import 'package:movie/features/home_screen/logic/theme_cubit/theme_cubit.dart';
import 'package:movie/features/home_screen/logic/translaton_cubit/translaton_cubit.dart';
import 'package:movie/features/more_movie_screen/data/models/more_movie_args.dart';
import 'package:movie/features/home_screen/logic/Slider/slider_cubit.dart';
import 'package:movie/features/home_screen/logic/genres/genres_cubit.dart';
import 'package:movie/features/home_screen/logic/top_Rated/top_rated_cubit.dart';
import 'package:movie/features/home_screen/logic/top_ten/top_ten_cubit.dart';
import 'package:movie/features/home_screen/logic/trending/trending_cubit.dart';
import 'package:movie/features/home_screen/logic/upcoming/upcoming_cubit.dart';
import 'package:movie/features/home_screen/ui/widget/image_scroll.dart';
import 'package:movie/features/home_screen/ui/widget/region_card.dart';
import 'package:easy_localization/easy_localization.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: BlocBuilder<AppBarScrollCubit, double>(
            builder: (context, opacity) {
              return AppBar(
                backgroundColor: context.appBarColor.withValues(alpha: opacity),
                elevation: 0,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.language),
                    onPressed: () {
                      context.read<TranslationCubit>().toggleLanguage(context);
                    },
                  ),
                  SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.brightness_6),
                    onPressed: () {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  ),
                ],
              );
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
                children: [
                  BlocBuilder<SliderCubit, SliderState>(
                    builder: (context, sliderState) {
                      if (sliderState is SliderSuccess) {
                        return CarouselSlider(
                          options: CarouselOptions(
                            height: 350,
                            viewportFraction: 1,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            autoPlayAnimationDuration: const Duration(
                              milliseconds: 900,
                            ),
                          ),
                          items: sliderState.results.map((movie) {
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(context, RouteNames.movieDetails.name, arguments: movie.id,),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "${Assets.baseUrl}${movie.posterPath}",
                                    ),
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withValues(alpha: 0.4),
                                      BlendMode.darken,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: context.isEnglish? EdgeInsets.only(bottom: 40, left: 30,) : EdgeInsets.only(bottom: 40, right: 30,),
                                  child: Align(
                                    alignment: context.isEnglish ? Alignment.bottomLeft : Alignment.bottomRight,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(movie.title!, style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold,),),
                                        const SizedBox(height: 5),
                                        BlocBuilder<GenresCubit, GenresState>(
                                          builder: (context, genreState) {
                                            if (genreState is GenreLoaded) {
                                              return Text(movie.genreNames(genreState.genreMap,), style: const TextStyle(color: Colors.white, fontSize: 12,),);
                                            } else {
                                              return const Text("");
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else if (sliderState is SliderFailure) {
                        return Center(
                          child: Text("errorMessage".tr()),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  const SizedBox(height: 15),

                  ///Top 10 Movies

                  RegionCard(
                    name: "Top 10 Movies This Week",
                    onViewMore: ()=>Navigator.of(context).pushNamed(AppRouteNames.moreMovieData , arguments: MoreMovieArgs(category: "week", title: "Top 10 Movies This Week" , isTopTen: true)),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<TopTenCubit, TopTenState>(
                    builder: (context, topTenState) {
                      if (topTenState is TopTenSuccess) {
                        return ImageScroll(movies: topTenState.movies);
                      } else if (topTenState is TopTenFailure) {
                        return Center(
                          child: Text(topTenState.error),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),


                  ///Now Playing
                  const SizedBox(height: 15),
                  RegionCard(
                    name: "nowPlayingMovies".tr(),
                    onViewMore: () {
                      Navigator.pushNamed(context, AppRouteNames.moreMovieData , arguments: MoreMovieArgs(category: "now_playing", title: "nowPlayingMovies".tr()));
                    },
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<NowPlayingCubit, NowPlayingState>(
                    builder: (context, nowPlayingState) {
                      if (nowPlayingState is NowPlayingSuccess) {
                        return ImageScroll(movies: nowPlayingState.movies);
                      } else if (nowPlayingState is NowPlayingFailure) {
                        return const Center(
                          child: Text("Failed to load movies"),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),

                  ///Upcoming Movies
                  const SizedBox(height: 15),
                  RegionCard(
                    name: "upcoming Movies",
                    onViewMore: () {
                      Navigator.pushNamed(context, AppRouteNames.moreMovieData , arguments: MoreMovieArgs(category: "upcoming", title: "upcoming Movies"));
                    },
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<UpcomingCubit, UpcomingState>(
                    builder: (context, upcoming) {
                      if (upcoming is UpcomingSuccess) {
                        return ImageScroll(movies: upcoming.movies);
                      } else if (upcoming is UpcomingFailure) {
                        return const Center(child: Text("Failed to load movies"),);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),

                  ///Popular Movies
                  const SizedBox(height: 15),
                  RegionCard(
                    name: "Popular Movies",
                    onViewMore: () {
                      Navigator.pushNamed(context, AppRouteNames.moreMovieData , arguments: MoreMovieArgs(category: "popular", title: "Popular Movies"));
                    },
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<TrendingCubit, TrendingState>(
                    builder: (context, topTrending) {
                      if (topTrending is TrendingSuccess) {
                        return ImageScroll(movies: topTrending.movies);
                      } else if (topTrending is TrendingFailure) {
                        return const Center(
                          child: Text("Failed to load movies"),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),


                  ///Top Rated Movies
                  const SizedBox(height: 15),
                  RegionCard(
                    name: "Top Rated Movies",
                    onViewMore: () {
                      Navigator.pushNamed(context, AppRouteNames.moreMovieData , arguments: MoreMovieArgs(category: "top_rated", title: "Top Rated Movies"));
                    },
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<TopRatedCubit, TopRatedState>(
                    builder: (context, topRated) {
                      if (topRated is TopRatedSuccess) {
                        return ImageScroll(movies: topRated.movies);
                      }else if (topRated is TopRatedFailure) {
                        return const Center(child: Text("Failed to load movies"),);
                      }else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),



                  ///Popular TV Shows
                  const SizedBox(height: 15),
                  RegionCard(
                    name: "Popular TV Shows",
                    onViewMore: () {
                      Navigator.pushNamed(context, AppRouteNames.moreMovieData , arguments: MoreMovieArgs(category: "popular", title: "Popular TV Shows" , isTVShow: true));
                    },
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<PopularTvCubit, PopularTvState>(
                    builder: (context, state) {
                      if (state is PopularTvSuccess) {
                        return ImageScroll(movies: state.movies , isTV: true);
                      }else if (state is  PopularTvFailure) {
                        return const Center(child: Text("Failed to load movies"),);
                      }else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),


                  ///On The Air TV
                  const SizedBox(height: 15),
                  RegionCard(
                    name: "On The Air",
                    onViewMore: () {
                      Navigator.pushNamed(context, AppRouteNames.moreMovieData , arguments: MoreMovieArgs(category: "on_the_air", title: "On The Air" , isTVShow: true));
                    },
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<OnTheAirCubit, OnTheAirState>(
                    builder: (context, state) {
                      if (state is OnTheAirSuccess) {
                        return ImageScroll(movies: state.results , isTV: true);
                      }else if (state is  OnTheAirFailure) {
                        return const Center(child: Text("Failed to load movies"),);
                      }else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  const SizedBox(height: 15),

                ],
              ),
            ),
          ),

    );
  }
}
