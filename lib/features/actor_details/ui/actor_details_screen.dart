import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie/core/constants/extensions/assets.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';
import 'package:movie/core/routing/app_route_names.dart';
import 'package:movie/features/actor_details/logic/actor_details/actor_details_cubit.dart';
import 'package:movie/features/actor_details/logic/actor_images/actor_images_cubit.dart';
import 'package:movie/features/actor_details/logic/actor_movie/actor_movie_cubit.dart';
import 'package:movie/features/actor_details/ui/widgets/info_row_widget.dart';
import 'package:readmore/readmore.dart';

class ActorDetailsScreen extends StatelessWidget {
  const ActorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text("Actor Details"),
          actions: [
            IconButton(onPressed: ()=>Navigator.pushNamed(context, AppRouteNames.search), icon: Icon(Icons.search))
          ],
        ),
        body: BlocBuilder<ActorDetailsCubit, ActorDetailsState>(
          builder: (context, state) {
            if (state is ActorDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ActorDetailsLoaded) {
              final actor = state.data;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          "${Assets.baseUrl}${actor.profilePath}",
                          height: 300,
                          width: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.network(Assets.errorImage, height: 300, width: 200, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      actor.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      actor.knownForDepartment,
                      style: TextStyle(
                        fontSize: 16,
                        color: context.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    InfoRowWidget(label: "Place of Birth", value: actor.placeOfBirth),
                    if (actor.birthday != null)
                      InfoRowWidget(label: "Birthday", value: DateFormat.yMMMMd().format(actor.birthday!)),
                    if (actor.deathday != null)
                      InfoRowWidget(label: "Deathday", value: DateFormat.yMMMMd().format(actor.deathday!)),
                    const SizedBox(height: 20),
                    const Text(
                      "Biography",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReadMoreText(
                      actor.biography,
                      trimLines: 5,
                      trimMode: TrimMode.Line,
                      style: const TextStyle(fontSize: 14, height: 1.5),
                      trimCollapsedText: ' Show more',
                      trimExpandedText: ' Show less',
                      moreStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: context.primaryColor,
                      ),
                      lessStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: context.primaryColor,
                      ),
                    ),
                    if (actor.alsoKnownAs.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      const Text(
                        "Also Known As",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: actor.alsoKnownAs.map((name) {
                          return Chip(
                            label: Text(name, style: const TextStyle(fontSize: 12)),
                            backgroundColor: context.primaryColor.withValues(alpha: 0.1),
                          );
                        }).toList(),
                      ),
                    ],
                    const SizedBox(height: 25),
                    const Text(
                      "Photos",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 150,
                      child: BlocBuilder<ActorImagesCubit, ActorImagesState>(
                        builder: (context, state) {
                          if (state is ActorImagesLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (state is ActorImagesSuccess) {
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.data.profiles.length,
                              separatorBuilder: (context, index) => const SizedBox(width: 10),
                              itemBuilder: (context, index) {
                                final image = state.data.profiles[index];
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "${Assets.baseUrl}${image.filePath}",
                                    width: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Image.network(Assets.errorImage, width: 100, fit: BoxFit.cover),
                                  ),
                                );
                              },
                            );
                          } else if (state is ActorImagesError) {
                            return Center(child: Text(state.message));
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Known For",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 250,
                      child: BlocBuilder<ActorMovieCubit, ActorMovieState>(
                        builder: (context, state) {
                          if (state is ActorMovieLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (state is ActorMovieSuccess) {
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.data.length,
                              separatorBuilder: (context, index) => const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                final movie = state.data[index];
                                return GestureDetector(
                                  onTap: () {
                                    if(movie.mediaType == "movie") {
                                      Navigator.pushNamed(context, AppRouteNames.movieDetails, arguments: movie.id);
                                    } else {
                                      Navigator.pushNamed(context, AppRouteNames.tvDetails, arguments: movie.id);
                                    }
                                  },
                                  child: SizedBox(
                                    width: 130,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.network(
                                              "${Assets.baseUrl}${movie.posterPath}",
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) =>
                                                  Image.network(Assets.errorImage, fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          movie.title ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (state is ActorMovieError) {
                            return Center(child: Text(state.message));
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            } else if (state is ActorDetailsError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
    );
  }
}
