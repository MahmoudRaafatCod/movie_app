import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constants/extensions/assets.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';
import 'package:movie/features/movie_details/logic/trailer/trailer_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class TrailersWidget extends StatelessWidget {
  const TrailersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrailerCubit, TrailerState>(
      builder: (context, state) {
        if (state is TrailerSuccess) {
          if(state.trailers.isEmpty) {
            return Center(child: Text('No trailers found.'));
          }
          return ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (_, index) {
              final trailer = state.trailers[index];
              return GestureDetector(
                onTap: () {
                  launchUrl(
                    Uri.parse("https://www.youtube.com/watch?v=${trailer.key}"),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "https://img.youtube.com/vi/${trailer.key}/maxresdefault.jpg",
                            width: 140,
                            height: 90,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                Assets.errorImage,
                                width: 140,
                                height: 90,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        Positioned.fill(
                          child: Center(
                            child: Icon(
                              Icons.play_circle_fill,
                              color: Colors.white54,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trailer.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: context.primaryColor.withValues(
                                alpha: 0.2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              trailer.type,
                              style: TextStyle(
                                color: context.primaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (_, _) => SizedBox(height: 15),
            itemCount: state.trailers.length,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
