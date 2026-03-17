import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie/core/constants/extensions/assets.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';
import 'package:movie/core/routing/app_route_names.dart';
import 'package:movie/features/search_screen/logic/search_cubit/search_cubit.dart';
import 'package:movie/features/search_screen/logic/search_focuse/search_focused_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/Sort_cubit/sort_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/genre_cubit/genre_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/regions_cubit/regions_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/selected_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/time_cubit/time_cubit.dart';
import 'package:movie/features/search_screen/ui/widget/bottom_sheet_content.dart';
import 'package:movie/features/search_screen/ui/widget/text_form_field_default_border_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  void openFilterBottomSheet(BuildContext parentContext) {
    showModalBottomSheet(
      context: parentContext,
      backgroundColor: parentContext.appBarColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
        builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: parentContext.read<SearchCubit>()),
              BlocProvider.value(value: parentContext.read<CategoryCubit>()),
              BlocProvider.value(value: parentContext.read<RegionsCubit>()),
              BlocProvider.value(value: parentContext.read<GenreCubit>()),
              BlocProvider.value(value: parentContext.read<TimeCubit>()),
              BlocProvider.value(value: parentContext.read<SortCubit>()),
            ],
            child: const BottomSheetContent(),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: context.width -100,
                      child: BlocBuilder<SearchFocusedCubit, bool>(
                        builder: (context, isFocused) {
                          return Focus(
                            onFocusChange: (hasFocus) {
                              context.read<SearchFocusedCubit>().setFocus(hasFocus);
                            },
                            child: TextFormField(
                              onTapOutside: (_) { FocusScope.of(context).unfocus(); },
                              controller: context.read<SearchCubit>().searchController,
                              onChanged: (_) => context.read<SearchCubit>().search(),
                              cursorColor: context.primaryColor,
                              decoration: InputDecoration(
                                hintText: "Search",
                                prefixIcon: Icon(Icons.search, color: isFocused ? context.primaryColor : Assets.grayColor),
                                suffixIcon: context.watch<SearchCubit>().searchController.text.isEmpty 
                                    ? null
                                    : GestureDetector(
                                        onTap: () {
                                          context.read<SearchCubit>().searchController.clear();
                                          context.read<SearchCubit>().getTrending();
                                        },
                                        child: Icon(CupertinoIcons.xmark, color: isFocused ? context.primaryColor : Assets.grayColor),
                                      ),
                                hintStyle: const TextStyle(color: Color(0xff707378)),
                                filled: true,
                                fillColor: isFocused ? context.primaryColor.withAlpha(20) : context.searchColor,
                                border: textFormFieldDefaultOutlineInputBorder(),
                                focusedBorder: textFormFieldDefaultOutlineInputBorder(borderColor: context.primaryColor),
                                enabledBorder: textFormFieldDefaultOutlineInputBorder(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Builder(
                      builder: (innerContext) {
                        return GestureDetector(
                          onTap: () => openFilterBottomSheet(innerContext),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: context.primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SvgPicture.asset('assets/icons/Filter.svg', width: 25, height: 25),
                          ),
                        );
                      }
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is SearchSuccess) {
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: context.isLandscape ? 5 : 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.7,
                          ),
                          itemBuilder: (_, index) {
                            final movie = state.searchResult[index];
                            return GestureDetector(
                              onTap: () {
                                if(movie.mediaType == "movie"){
                                Navigator.pushNamed(context, AppRouteNames.movieDetails, arguments: movie.id);
                                }else{
                                  Navigator.pushNamed(context, AppRouteNames.tvDetails, arguments: movie.id);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage("${Assets.baseUrl}${movie.posterPath}"),
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
                                          movie.mediaType ?? movie.voteAverage.toStringAsFixed(1),
                                        style: const TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: state.searchResult.length,
                        );
                      } else if (state is SearchError) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(context.imagesError),
                            const SizedBox(height: 10),
                            Text("Not Found", style: TextStyle(color: context.primaryColor, fontSize: 25)),
                            const SizedBox(height: 15),
                            const Text("Sorry, the keyword you entered could not be found.", textAlign: TextAlign.center),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }
}
