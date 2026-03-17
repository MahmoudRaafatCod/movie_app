import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/core/network/api_consumer.dart';
import 'package:movie/core/network/dio_consumer.dart';
import 'package:movie/features/home_screen/data/home_repo.dart';
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
import 'package:movie/features/more_movie_screen/data/models/more_movie_args.dart';
import 'package:movie/features/more_movie_screen/logic/data_movie/data_move_cubit.dart';
import 'package:movie/features/navigation_screen/logic/bottom_navigation_bar/nav_cubit.dart';
import 'package:movie/features/search_screen/data/search_repo.dart';
import 'package:movie/features/search_screen/logic/search_cubit/search_cubit.dart';
import 'package:movie/features/search_screen/logic/search_focuse/search_focused_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/Sort_cubit/sort_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/genre_cubit/genre_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/regions_cubit/regions_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/selected_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/time_cubit/time_cubit.dart';

class DependencyInjection{
  static final GetIt getIt = GetIt.instance;

  static Future<void> init() async {
    /// Dio Consumer
    getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(Dio()));

    /// Repos
    getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt<ApiConsumer>()));
    getIt.registerLazySingleton<SearchRepo>(() => SearchRepo(getIt<ApiConsumer>()));

    /// Cubits
    /// Nav
    getIt.registerFactory<NavCubit>(() => NavCubit());



    /// Home
    getIt.registerFactory<SliderCubit>(() => SliderCubit(getIt<HomeRepo>()));
    getIt.registerFactory<GenresCubit>(() => GenresCubit(getIt<HomeRepo>()));
    getIt.registerFactory<TopTenCubit>(() => TopTenCubit(getIt<HomeRepo>()));
    getIt.registerFactory<TrendingCubit>(() => TrendingCubit(getIt<HomeRepo>()));
    getIt.registerFactory<TopRatedCubit>(() => TopRatedCubit(getIt<HomeRepo>()));
    getIt.registerFactory<UpcomingCubit>(() => UpcomingCubit(getIt<HomeRepo>()));
    getIt.registerFactory<AppBarScrollCubit>(() => AppBarScrollCubit());
    getIt.registerFactory<NowPlayingCubit>(() => NowPlayingCubit(getIt<HomeRepo>()));
    getIt.registerFactory<PopularTvCubit>(() => PopularTvCubit(getIt<HomeRepo>()));
    getIt.registerFactory<OnTheAirCubit>(() => OnTheAirCubit(getIt<HomeRepo>()));

    ///Search
    getIt.registerFactory<SearchFocusedCubit>(() => SearchFocusedCubit());
    getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt<SearchRepo>()));
    getIt.registerFactory<CategoryCubit>(() => CategoryCubit());
    getIt.registerFactory<RegionsCubit>(() => RegionsCubit());
    getIt.registerFactory<GenreCubit>(() => GenreCubit(getIt<HomeRepo>()));
    getIt.registerFactory<TimeCubit>(() => TimeCubit());
    getIt.registerFactory<SortCubit>(() => SortCubit());

    /// More Movie Screen
    getIt.registerFactoryParam<DataMoveCubit , MoreMovieArgs , void>((args , _) => DataMoveCubit(getIt<HomeRepo>(), args: args));




    // getIt.registerFactoryParam<DetailsCubit, String, void>((countryName, _) => DetailsCubit(getIt<DetailsRepo>(), countryName: countryName));
  }
}
