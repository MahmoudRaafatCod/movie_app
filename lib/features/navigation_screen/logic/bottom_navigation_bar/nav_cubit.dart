
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home_screen/ui/home_screen.dart';
import 'package:movie/features/my_list/ui/my_list_screen.dart';
import 'package:movie/features/profile/ui/profile_screen.dart';
import 'package:movie/features/search_screen/ui/search_screen.dart';



class NavCubit extends Cubit<int> {
  NavCubit() : super(0);

  final List<Widget> pages = [
    HomeScreen(),
    SearchScreen(),
    MyListScreen(),
    ProfileScreen(),
  ];
  
  void changeIndex(int index) {
    emit(index);
  }
}
