import 'package:flutter/material.dart';
import 'package:movie/core/constants/extensions/assets.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';
import 'package:movie/core/routing/app_route_names.dart';

class ImageScroll extends StatelessWidget {
  final List<dynamic> movies;
  final bool isTV;
  const ImageScroll({super.key, required this.movies , this.isTV = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Padding(
        padding: context.isEnglish ? const EdgeInsets.only(left: 15) : const EdgeInsets.only(right: 15),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (_, index) {
            final movie = movies[index];
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
                      "${Assets.baseUrl}${movie.posterPath}",), fit: BoxFit.fill,),
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
          separatorBuilder: (_, index) => const SizedBox(width: 10),
        ),
      ),
    );
  }
}
