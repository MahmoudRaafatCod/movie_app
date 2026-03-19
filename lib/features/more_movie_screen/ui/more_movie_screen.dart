import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constants/extensions/assets.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';
import 'package:movie/core/routing/app_route_names.dart';
import 'package:movie/features/more_movie_screen/logic/data_movie/data_move_cubit.dart';

class MoreMovieScreen extends StatelessWidget {
  const MoreMovieScreen({super.key});
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<DataMoveCubit, DataMoveState>(
        builder: (context, state) {
          if (state is DataMoveLoaded) {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(context.read<DataMoveCubit>().name , style: TextStyle(color: context.textColor),),
                  actions: [Icon(Icons.search), SizedBox(width: 10)],
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.7,
                              ),
                          itemBuilder: (_, index) {
                            final movie = state.movies[index];
                            return GestureDetector(
                              onTap: () {
                                if(context.read<DataMoveCubit>().args.isTVShow){
                                  Navigator.pushNamed(context, AppRouteNames.tvDetails, arguments: movie.id,);
                                } else {
                                Navigator.pushNamed(context, AppRouteNames.movieDetails, arguments: movie.id,);
                                }
                              },
                              child: Container(
                                width: 180,
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
                                        movie.voteAverage.toStringAsFixed(1),
                                        style: TextStyle(
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
                          itemCount: state.movies.length,
                        ),

                        SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.primaryColor,
                            ),
                            onPressed: () =>
                                context.read<DataMoveCubit>().loadMore(),
                            child: Text(
                              "Load More",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
    );
  }
}
