import 'package:bingo/bingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie/core/dependency_injection/dependency_injection.dart';
import 'package:movie/features/home_screen/data/models/genre_model.dart';
import 'package:movie/features/home_screen/data/models/genres_model.dart';
import 'package:movie/movie_app.dart';
import 'package:easy_localization/easy_localization.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Bingo.setup();
  Bingo.register<GenresModel>((json) => GenresModel.fromJson(json));
  Bingo.register<GenreModel>((json) => GenreModel.fromJson(json));
  DependencyInjection.init();

  runApp(EasyLocalization(supportedLocales: [Locale("en"), Locale("ar")], path: "assets/translations", fallbackLocale: Locale("en"), child: MovieApp()));

}