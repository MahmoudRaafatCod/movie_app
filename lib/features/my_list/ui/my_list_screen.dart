import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constants/extensions/assets.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';
import 'package:movie/core/routing/route_names.dart';
import 'package:movie/features/my_list/logic/saved_movies/saved_movies_cubit.dart';
import 'package:movie/features/my_list/ui/widget/button_custom.dart';

class MyListScreen extends StatelessWidget {
  const MyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My List" , style: TextStyle(color: context.textColor ,  fontFamily: Assets.cairoFont),),

          actions: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context, RouteNames.search.name);
            }, icon: Icon(Icons.search))
          ],
        ),
        body: BlocBuilder<SavedMoviesCubit, SavedMoviesState>(
          builder: (context, favorites) {
            if (favorites is SavedMoviesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (favorites is SavedMoviesError) {
              return Center(child: Text(favorites.message));
            } else if (favorites is SavedMoviesLoaded) {
              if (favorites.movies.isEmpty) {
                return  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Image.asset(context.isDark? Assets.isEmptyImageDark : Assets.isEmptyImage)),
                    SizedBox(height: 50,),
                    Text("Your List is Empty" , style: TextStyle(color: context.primaryColor , fontSize: 20 , fontWeight: FontWeight.bold , fontFamily: Assets.cairoFont),),
                    SizedBox(height: 20,),
                    Text("it seems that you haven't added \n any movies to the list" , style: TextStyle(fontSize: 16 , fontFamily: Assets.cairoFont) , textAlign: TextAlign.center,)
                  ],
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        if(favorites.hasMovies && favorites.hasTv)
                        ButtonCustom(text: "All", onPressed: ()=>context.read<SavedMoviesCubit>().loadInstallment(),isSelected: favorites.selectedType == ""),
                        const SizedBox(width: 5),
                        if(favorites.hasMovies)
                        ButtonCustom(
                          text: "Movies",
                          onPressed: () => context.read<SavedMoviesCubit>().loadInstallment(type: "movie"), isSelected: favorites.selectedType == "movie"
                        ),
                        const SizedBox(width: 5),
                        if(favorites.hasTv)
                        ButtonCustom(
                        text: "TV",
                        onPressed: ()=>context.read<SavedMoviesCubit>().loadInstallment(type: "tv") , isSelected: favorites.selectedType == "tv"
                      ),

                        Spacer(),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.scale,
                                title: 'Confirm Delete',
                                desc: 'Are you sure you want to clear the list?',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {
                                  context.read<SavedMoviesCubit>().clearMovies();
                                },
                                btnOkColor: Colors.redAccent,
                              ).show();
                            },
                            icon: const Icon(Icons.delete_outline),
                            color: Colors.redAccent,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),

                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: context.isLandscape ? 5 : 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (_, index) {
                          final movie = favorites.movies[index];
                          return GestureDetector(
                            onTap: () {
                              if (movie.mediaType == "movie") {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.movieDetails.name,
                                  arguments: movie.id,
                                );
                              } else {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.tvDetails.name,
                                  arguments: movie.id,
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "${Assets.baseUrl}${movie.posterPath}",
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: context.primaryColor,
                                    ),
                                    child: Text(
                                      movie.mediaType,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: favorites.movies.length,
                      ),
                    ),
                  ],
                ),
              );
            }else {
              return Container();
            }
          }
        ),
    );
  }
}
