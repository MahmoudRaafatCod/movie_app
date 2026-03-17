import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie/core/constants/extensions/assets.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';
import 'package:movie/features/navigation_screen/logic/bottom_navigation_bar/nav_cubit.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, int>(
      builder: (context, index) {
        final cubit = context.read<NavCubit>();

        return Scaffold(
          body: IndexedStack(
            index: index,
            children: cubit.pages,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: context.shadowColor,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: index,
              onTap: (i) {
                cubit.changeIndex(i);
              },
              backgroundColor: context.scaffoldBackgroundColor,
              selectedItemColor: context.primaryColor,
              unselectedItemColor: context.navBarUnselectedColor,
              type: BottomNavigationBarType.fixed,
              unselectedLabelStyle: TextStyle(
                fontFamily: Assets.cairoFont,
              ),
              selectedLabelStyle: TextStyle(
                fontFamily: Assets.cairoFont,
              ),
              showSelectedLabels: true,
              // showUnselectedLabels: false,
              elevation: 0,
              items:  [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/Home.svg', width: 20, height: 20,),
                  activeIcon: SvgPicture.asset('assets/icons/Home2.svg', width: 25, height: 25),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/Discovery.svg', width: 20, height: 20,),
                  activeIcon: SvgPicture.asset('assets/icons/Discovery2.svg', width: 25, height: 25),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/Bookmark.svg', width: 20, height: 20,),
                  activeIcon: SvgPicture.asset('assets/icons/Bookmark2.svg', width: 25, height: 25),
                  label: "Favorites",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/Profile.svg', width: 20, height: 20,),
                  activeIcon: SvgPicture.asset('assets/icons/Profile2.svg', width: 25, height: 25),
                  label: "Profile",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
