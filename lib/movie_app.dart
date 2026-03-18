import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:movie/core/theme/theme.dart';
import 'package:movie/features/home_screen/logic/theme_cubit/theme_cubit.dart';
import 'package:movie/features/home_screen/logic/translaton_cubit/translaton_cubit.dart';
import 'package:movie/features/my_list/logic/saved_movies/saved_movies_cubit.dart';
import 'package:movie/features/navigation_screen/logic/bottom_navigation_bar/nav_cubit.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TranslationCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => SavedMoviesCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            key: ValueKey(context.locale),

            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,

            title: "movie App",
            onGenerateRoute: AppRouter.onGenerateRoute,
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: themeMode,
          );
        },
      ),
    );
  }
}