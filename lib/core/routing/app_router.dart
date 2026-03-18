import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/dependency_injection/dependency_injection.dart';
import 'package:movie/core/routing/app_route_names.dart';
import 'package:movie/features/actor_details/logic/actor_details/actor_details_cubit.dart';
import 'package:movie/features/actor_details/logic/actor_images/actor_images_cubit.dart';
import 'package:movie/features/actor_details/logic/actor_movie/actor_movie_cubit.dart';
import 'package:movie/features/actor_details/ui/actor_details_screen.dart';
import 'package:movie/features/home_screen/logic/Slider/slider_cubit.dart';
import 'package:movie/features/home_screen/logic/app_bar_scroll/app_bar_scroll_cubit.dart';
import 'package:movie/features/home_screen/logic/genres/genres_cubit.dart';
import 'package:movie/features/home_screen/logic/now_playing/now_playing_cubit.dart';
import 'package:movie/features/home_screen/logic/on_the_air_tv/on_the_air_cubit.dart';
import 'package:movie/features/home_screen/logic/popular_tv/popular_tv_cubit.dart';
import 'package:movie/features/home_screen/logic/top_Rated/top_rated_cubit.dart';
import 'package:movie/features/home_screen/logic/top_ten/top_ten_cubit.dart';
import 'package:movie/features/home_screen/logic/trending/trending_cubit.dart';
import 'package:movie/features/home_screen/logic/upcoming/upcoming_cubit.dart';
import 'package:movie/features/home_screen/ui/home_screen.dart';
import 'package:movie/features/more_movie_screen/data/models/more_movie_args.dart';
import 'package:movie/features/more_movie_screen/logic/data_movie/data_move_cubit.dart';
import 'package:movie/features/more_movie_screen/ui/more_movie_screen.dart';
import 'package:movie/features/movie_details/logic/caste_details/caste_details_cubit.dart';
import 'package:movie/features/movie_details/logic/more_like_this/similar_cubit.dart';
import 'package:movie/features/movie_details/logic/movie_details/movie_details_cubit.dart';
import 'package:movie/features/movie_details/logic/review/review_cubit.dart';
import 'package:movie/features/movie_details/logic/tap_text/tap_cubit.dart';
import 'package:movie/features/movie_details/logic/trailer/trailer_cubit.dart';
import 'package:movie/features/movie_details/ui/movie_details_screen.dart';
import 'package:movie/features/my_list/ui/my_list_screen.dart';
import 'package:movie/features/navigation_screen/logic/bottom_navigation_bar/nav_cubit.dart';
import 'package:movie/features/navigation_screen/ui/navigation_screen.dart';
import 'package:movie/features/search_screen/logic/search_cubit/search_cubit.dart';
import 'package:movie/features/search_screen/logic/search_focuse/search_focused_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/Sort_cubit/sort_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/genre_cubit/genre_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/regions_cubit/regions_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/selected_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/time_cubit/time_cubit.dart';
import 'package:movie/features/search_screen/ui/search_screen.dart';
import 'package:movie/features/tv_details/logic/tv_details/tv_details_cubit.dart';
import 'package:movie/features/tv_details/logic/tv_season_details/tv_season_cubit.dart';
import 'package:movie/features/tv_details/ui/tv_derails_screen.dart';
import 'package:movie/features/tv_episodes_derails/logic/episode_details/episode_details_cubit.dart';
import 'package:movie/features/tv_episodes_derails/ui/tv_episodes_details_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      /// Navigation Screen
      case AppRouteNames.nav:
        return MaterialPageRoute(builder: (_) =>  MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => DependencyInjection.getIt<NavCubit>()),

            BlocProvider(create: (context) => DependencyInjection.getIt<SearchFocusedCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<SearchCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<CategoryCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<RegionsCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<GenreCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<TimeCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<SortCubit>()),

            BlocProvider(create: (context) => DependencyInjection.getIt<SliderCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<GenresCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<TopTenCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<TrendingCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<TopRatedCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<UpcomingCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<AppBarScrollCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<NowPlayingCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<PopularTvCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<OnTheAirCubit>()),

          ],
          child: const NavigationScreen(),
        ),);
      /// Home Screen
      case AppRouteNames.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());

        /// Search Screen
        case AppRouteNames.search:
        return MaterialPageRoute(builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => DependencyInjection.getIt<SearchFocusedCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<SearchCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<CategoryCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<RegionsCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<GenreCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<TimeCubit>()),
            BlocProvider(create: (context) => DependencyInjection.getIt<SortCubit>()),
          ],
          child:SearchScreen()));


        /// More Movie Screen
      case AppRouteNames.moreMovieData:
        return  MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => DependencyInjection.getIt<DataMoveCubit>(param1: settings.arguments as MoreMovieArgs),
              child: MoreMovieScreen(),
            ));


      /// Movie Details Screen

      case AppRouteNames.movieDetails:
        return MaterialPageRoute(builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => DependencyInjection.getIt<TapCubit>()),
              BlocProvider(create: (context) => DependencyInjection.getIt<AppBarScrollCubit>()),
              BlocProvider(create: (context) => DependencyInjection.getIt<MovieDetailsCubit>(param1: settings.arguments as int)),
              BlocProvider(create: (context) => DependencyInjection.getIt<CasteDetailsCubit>(param1: settings.arguments as int , param2: "movie")),
              BlocProvider(create: (context) => DependencyInjection.getIt<TrailerCubit>(param1: settings.arguments as int , param2: "movie")),
              BlocProvider(create: (context) => DependencyInjection.getIt<SimilarCubit>(param1: settings.arguments as int , param2: "movie")),
              BlocProvider(create: (context) => DependencyInjection.getIt<ReviewCubit>(param1: settings.arguments as int , param2: "movie")),
            ],
            child:MovieDetailsScreen()));


      /// TV Details Screen
      case AppRouteNames.tvDetails:
        return MaterialPageRoute(builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => DependencyInjection.getIt<TapCubit>()),
              BlocProvider(create: (context) => DependencyInjection.getIt<AppBarScrollCubit>()),
              BlocProvider(create: (context) => DependencyInjection.getIt<TvDetailsCubit>(param1: settings.arguments as int)),
              BlocProvider(create: (context) => DependencyInjection.getIt<TvSeasonCubit>(param1: settings.arguments as int)),
              BlocProvider(create: (context) => DependencyInjection.getIt<CasteDetailsCubit>(param1: settings.arguments as int , param2: "tv")),
              BlocProvider(create: (context) => DependencyInjection.getIt<TrailerCubit>(param1: settings.arguments as int , param2: "tv")),
              BlocProvider(create: (context) => DependencyInjection.getIt<SimilarCubit>(param1: settings.arguments as int , param2: "tv")),
              BlocProvider(create: (context) => DependencyInjection.getIt<ReviewCubit>(param1: settings.arguments as int , param2: "tv")),
            ],
            child:TvDerailsScreen()));

      /// More Movie Screen
      case AppRouteNames.tvEpisodeDetails:
        return  MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => DependencyInjection.getIt<EpisodeDetailsCubit>(param1: settings.arguments as Map<String , dynamic>),
              child: TvEpisodesDetailsScreen(),
            ));


      /// Actor Details Screen
      case AppRouteNames.actorDetails:
        return MaterialPageRoute(builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => DependencyInjection.getIt<ActorDetailsCubit>(param1: settings.arguments as int)),
              BlocProvider(create: (context) => DependencyInjection.getIt<ActorMovieCubit>(param1: settings.arguments as int)),
              BlocProvider(create: (context) => DependencyInjection.getIt<ActorImagesCubit>(param1: settings.arguments as int)),
            ],
            child:ActorDetailsScreen()));


    /// My List Screen
      case AppRouteNames.myList:
        return  MaterialPageRoute(builder: (_) => MyListScreen());


      default:
        return MaterialPageRoute(builder: (_) => Scaffold());
    }
  }
}
