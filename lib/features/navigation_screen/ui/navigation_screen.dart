import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';
import 'package:movie/features/navigation_screen/logic/bottom_navigation_bar/nav_cubit.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, int>(
      builder: (context, index) {
        return SafeArea(
          top: false,
          child: Scaffold(
            body: IndexedStack(
              index: index,
              children: context.read<NavCubit>().pages,
            ),
            bottomNavigationBar: CurvedNavigationBar(
              index: index,
              onTap: (i) {
                context.read<NavCubit>().changeIndex(i);
              },
              backgroundColor: context.scaffoldBackgroundColor,
              color: context.navBarBgColor,
              buttonBackgroundColor: context.primaryColor,
              animationDuration: const Duration(milliseconds: 300),
              items: [
                Icon(
                  index == 0 ? Icons.home_rounded : Icons.home_outlined,
                  color: index == 0 ? Colors.white : context.inactiveIconColor,
                  size: 28,
                ),
                Icon(
                  index == 1 ? Icons.search_rounded : Icons.search_outlined,
                  color: index == 1 ? Colors.white : context.inactiveIconColor,
                  size: 28,
                ),
                Icon(
                  index == 2 ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                  color: index == 2 ? Colors.white : context.inactiveIconColor,
                  size: 28,
                ),
                Icon(
                  index == 3 ? Icons.settings_rounded : Icons.settings_outlined,
                  color: index == 3 ? Colors.white : context.inactiveIconColor,
                  size: 28,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
