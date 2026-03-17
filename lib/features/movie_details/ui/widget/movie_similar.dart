import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constants/extensions/assets.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';
import 'package:movie/core/routing/app_route_names.dart';
import 'package:movie/features/movie_details/logic/more_like_this/similar_cubit.dart';

class MovieSimilar extends StatelessWidget {
  final bool isTV;

  const MovieSimilar({super.key , this.isTV = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilarCubit, SimilarState>(
      builder: (context, state) {
        if (state is SimilarSuccess) {
          return GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (_, index) {
              final movie = state.movies[index];
              return GestureDetector(
                onTap: () {
                  if(isTV){
                    Navigator.pushNamed(context, AppRouteNames.tvDetails, arguments: movie.id,);
                  }else{
                  Navigator.pushNamed(context, AppRouteNames.movieDetails, arguments: movie.id,);
                  }
                },
                child: Container(
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(
                        movie.posterPath == null
                            ? Assets.baseUrl
                            : "${Assets.baseUrl}${movie.posterPath}",
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
                          movie.voteAverage.toStringAsFixed(1),
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: state.movies.length,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
