import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constants/extensions/assets.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';
import 'package:movie/core/routing/route_names.dart';
import 'package:movie/features/tv_episodes_derails/logic/episode_details/episode_details_cubit.dart';
import 'package:readmore/readmore.dart';

class TvEpisodesDetailsScreen extends StatelessWidget {
  const TvEpisodesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int tvShowId = args['tvShowId'];
    final int seasonNumber = args['seasonNumber'];
    final int episodeNumber = args['episodeNumber'];

    return BlocProvider(
      create: (context) => EpisodeDetailsCubit()
        ..getEpisodeDetails(tvShowId, seasonNumber, episodeNumber),
      child: Scaffold(

        body: BlocBuilder<EpisodeDetailsCubit, EpisodeDetailsState>(
          builder: (context, state) {
            if (state is EpisodeDetailsSuccess) {
              final episode = state.data;
              final textTheme = Theme.of(context).textTheme;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 250,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        episode.stillPath != null
                            ? "${Assets.baseUrl}${episode.stillPath}"
                            : Assets.errorImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            episode.name ?? "No Title",
                            style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                episode.voteAverage?.toStringAsFixed(1) ?? "0.0",
                                style: textTheme.bodyLarge,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                "S${episode.seasonNumber} E${episode.episodeNumber}",
                                style: textTheme.bodyLarge?.copyWith(
                                  color: context.primaryColor,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                episode.airDate ?? "",
                                style: textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Overview",
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ReadMoreText(
                            episode.overview ?? "No Overview",
                            trimLines: 4,
                            trimMode: TrimMode.Line,
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
                          const SizedBox(height: 24),
                          if (episode.guestStars != null &&
                              episode.guestStars!.isNotEmpty) ...[
                            Text(
                              "Guest Stars",
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 160,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: episode.guestStars!.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 12),
                                itemBuilder: (context, index) {
                                  final guest = episode.guestStars![index];
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, RouteNames.actorDetails.name, arguments: guest.id);
                                    },
                                    child: SizedBox(
                                      width: 100,
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                              guest.profilePath != null
                                                  ? "${Assets.baseUrl}${guest.profilePath}"
                                                  : Assets.errorImage,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            guest.name ?? "",
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: textTheme.bodySmall?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            guest.character ?? "",
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textTheme.labelSmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                          if (episode.crew != null &&
                              episode.crew!.isNotEmpty) ...[
                            Text(
                              "Crew",
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 160,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: episode.crew!.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 12),
                                itemBuilder: (context, index) {
                                  final crew = episode.crew![index];
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, RouteNames.actorDetails.name, arguments: crew.id);
                                    },
                                    child: SizedBox(
                                      width: 100,
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                              crew.profilePath != null
                                                  ? "${Assets.baseUrl}${crew.profilePath}"
                                                  : Assets.errorImage,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            crew.name ?? "",
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: textTheme.bodySmall?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            crew.job ?? "",
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textTheme.labelSmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is EpisodeDetailsError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
