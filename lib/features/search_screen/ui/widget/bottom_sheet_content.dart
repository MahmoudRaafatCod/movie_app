import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constants/extensions/assets.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';
import 'package:movie/features/search_screen/logic/search_cubit/search_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/Sort_cubit/sort_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/genre_cubit/genre_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/regions_cubit/regions_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/selected_cubit.dart';
import 'package:movie/features/search_screen/logic/selected_cubit/time_cubit/time_cubit.dart';
import 'package:movie/features/search_screen/ui/widget/botton_widget.dart';
import 'package:movie/features/search_screen/ui/widget/selected_bottom.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Center(child: Text("sort_filter".tr() , style: TextStyle(color: context.primaryColor.withAlpha(170) , fontSize: 20 , fontWeight: FontWeight.bold , fontFamily: Assets.cairoFont),)),
          const SizedBox(height: 10,),
          Divider(),
          const SizedBox(height: 20,),


          Text("categories".tr() , style: TextStyle( fontSize: 16 , fontWeight: FontWeight.bold , fontFamily: Assets.cairoFont),),
          const SizedBox(height: 10,),
          BlocBuilder<CategoryCubit, int>(
            builder: (context, state) {
              return Row(
                children: [
                  SelectedBottom(text: "Movies",isSelected: state == 0 ,onTap: (){
                    context.read<CategoryCubit>().selectCategory(0);
                    context.read<SearchCubit>().setType("movie");
                  }),
                  const SizedBox(width: 10,),
                  SelectedBottom(text: "TV Shows",isSelected: state == 1 ,onTap: (){
                    context.read<CategoryCubit>().selectCategory(1);
                    context.read<SearchCubit>().setType("tv");
                  })
                ],
              );
            },
          ),
          const SizedBox(height: 20,),


          Text("regions".tr() , style: TextStyle( fontSize: 16 , fontWeight: FontWeight.bold , fontFamily: Assets.cairoFont)),
          const SizedBox(height: 10,),
          SizedBox(
            height: 35,
            child: BlocBuilder<RegionsCubit, List<Map<String, String>>>(
              builder: (context, state) {
                return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  final language = state[index];
                  final String name = language["name"] ?? "";
                  final String code = language["code"] ?? "all";
                return SelectedBottom(
                  text: name, isSelected: context.read<RegionsCubit>().selectedLanguage == code , onTap: () {
                    context.read<RegionsCubit>().selectLanguage(code);
                    context.read<SearchCubit>().setLanguage(code);
                     });
                   },
                separatorBuilder: (_,_) => const SizedBox(width: 10,),
                itemCount: state.length);
              },
            ),
          ),
          const SizedBox(height: 20,),


          Text("genre".tr() , style: TextStyle( fontSize: 16 , fontWeight: FontWeight.bold , fontFamily: Assets.cairoFont)),
          const SizedBox(height: 10,),
          SizedBox(
            height: 35,
            child: BlocBuilder<GenreCubit, GenreState>(
              builder: (context, state) {
                if (state is GenreLoaded) {
                  final genres = state.genreMap.entries.toList();
                  return
                    ListView.separated(
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          final genre = genres[index];
                          return SelectedBottom(
                          text: genre.value, isSelected: context.read<SearchCubit>().genreId.contains(genre.key), onTap: () {
                            context.read<GenreCubit>().selectGenre(genre.key);
                            context.read<SearchCubit>().toggleGenre(genre.key);

                          });
                        },
                        separatorBuilder: (_,_) => const SizedBox(width: 10,),
                        itemCount: genres.length);
                } else {
                  return Container();
                }
              },
            ),
          ),
          const SizedBox(height: 20,),


          Text("time_periods".tr() , style: TextStyle( fontSize: 16 , fontWeight: FontWeight.bold , fontFamily: Assets.cairoFont)),
          const SizedBox(height: 10,),
          SizedBox(
            height: 35,
            child: BlocBuilder<TimeCubit, List<dynamic>>(
              builder: (context, state) {
                return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final year = state[index];
                      return SelectedBottom(text: year.toString(),isSelected: context.read<TimeCubit>().selectedYear == year ,onTap: (){
                        context.read<TimeCubit>().selectYear(year);
                        context.read<SearchCubit>().setYear(year is int ? year : null);
                      });
                    },
                    separatorBuilder: (_,_) => SizedBox(width: 10,),
                    itemCount: state.length);
              },
            ),
          ),
          const SizedBox(height: 20,),


          Text("sort".tr() , style: TextStyle( fontSize: 16 , fontWeight: FontWeight.bold , fontFamily: Assets.cairoFont)),
          const SizedBox(height: 10,),
          SizedBox(
            height: 35,
            child: BlocBuilder<SortCubit, List<Map<String, String>>>(
              builder: (context, state) {
                return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final sortOption = state[index];
                      final String nameKey = sortOption["name"] ?? "";
                      final String code = sortOption["code"] ?? "popularity.desc";
                      return SelectedBottom(
                      text: nameKey.tr(), isSelected: context.read<SortCubit>().selectedSort == nameKey , onTap: () {
                        context.read<SortCubit>().selectSort(nameKey);
                        context.read<SearchCubit>().setSortBy(code);
                      });
                    },
                    separatorBuilder: (_,_) => const SizedBox(width: 10,),
                    itemCount: state.length);
              },
            ),
          ),
          const SizedBox(height: 10,),
          Divider(),
          const SizedBox(height: 10,),


           Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonWidget(text: "reset".tr(),color: context.buttonColor, textColor: context.textButtonColor, onPressed: (){
                context.read<RegionsCubit>().selectLanguage("all");
                context.read<SearchCubit>().resetGenres();
                context.read<GenreCubit>().getGenres();
                context.read<TimeCubit>().selectYear("All Time");
                context.read<SortCubit>().selectSort("most_popular");
                context.read<SearchCubit>().getTrending();
              },),
              ButtonWidget(text: "apply".tr(),color: context.primaryColor, onPressed: (){
                context.read<SearchCubit>().filter();
                Navigator.pop(context);
              },),

            ],
          )
        ],
      ),
    );
  }
}
