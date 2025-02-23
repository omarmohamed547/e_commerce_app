import 'package:e_commerce_app/feature/home/cubit/home_screen_states.dart';
import 'package:e_commerce_app/feature/home/tabs/Heart_tab.dart';
import 'package:e_commerce_app/feature/home/tabs/home_tab/home_tab.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/product_scree.dart';
import 'package:e_commerce_app/feature/home/tabs/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenViewmodel extends Cubit<HomeScreenStates> {
  HomeScreenViewmodel() : super(homeScreenIntialState());

  int selectedIndex = 0;
  List<Widget> tabs = [HomeTab(), ProductTabScreen(), HeartTab(), ProfileTab()];
  void onTabbottom(int index) {
    selectedIndex = index;
    emit(homeScreenchangeIndexState());
  }
}
