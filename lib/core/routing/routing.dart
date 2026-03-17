import 'package:movie/features/actor_details/ui/actor_details_screen.dart';
import 'package:movie/features/home_screen/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:movie/features/more_movie_screen/ui/more_movie_screen.dart';
import 'package:movie/features/movie_details/ui/movie_details_screen.dart';
import 'package:movie/features/my_list/ui/my_list_screen.dart';
import 'package:movie/features/navigation_screen/ui/navigation_screen.dart';
import 'package:movie/features/profile/ui/profile_screen.dart';
import 'package:movie/features/search_screen/ui/search_screen.dart';
import 'package:movie/features/tv_details/ui/tv_derails_screen.dart';
import 'package:movie/features/tv_episodes_derails/ui/tv_episodes_details_screen.dart';
import 'route_names.dart';

class Routing {
  static Map<String, Widget Function(BuildContext)> routes = {
    RouteNames.home.name: (context) => const HomeScreen(),
    RouteNames.nav.name: (context) => const NavigationScreen(),
    RouteNames.moreMovieData.name: (context) => const MoreMovieScreen(),
    RouteNames.movieDetails.name: (context) => const MovieDetailsScreen(),
    RouteNames.search.name: (context) => const SearchScreen(),
    RouteNames.tvDetails.name: (context) => const TvDerailsScreen(),
    RouteNames.tvEpisodeDetails.name: (context) => const TvEpisodesDetailsScreen(),
    RouteNames.myList.name: (context) => const MyListScreen(),
    RouteNames.actorDetails.name: (context) => const ActorDetailsScreen(),
    RouteNames.profile.name: (context) => const ProfileScreen(),
  };
}
