import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/feature/home/cubit/home_screen_states.dart';
import 'package:e_commerce_app/feature/home/cubit/home_screen_viewmodel.dart';
import 'package:e_commerce_app/feature/home/tabs/Heart_tab.dart';
import 'package:e_commerce_app/feature/home/tabs/home_tab/home_tab.dart';
import 'package:e_commerce_app/feature/home/tabs/profile_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewmodel homeScreenViewmodel = HomeScreenViewmodel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenViewmodel, HomeScreenStates>(
      bloc: homeScreenViewmodel,
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              child: BottomNavigationBar(
                  onTap: (value) {
                    homeScreenViewmodel.onTabbottom(value);
                  },
                  currentIndex: homeScreenViewmodel.selectedIndex,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: AppColors.primaryColorLight,
                  items: [
                    BottomNavigationBarItem(
                      icon: TabIcon(
                        icon: 'assets/icons/home (1) 3.png',
                        index: 0,
                        selectedIndex: homeScreenViewmodel.selectedIndex,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: TabIcon(
                        icon: 'assets/icons/category (1) 3.png',
                        index: 1,
                        selectedIndex: homeScreenViewmodel.selectedIndex,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: TabIcon(
                        icon: 'assets/icons/heart (3) 3.png',
                        index: 2,
                        selectedIndex: homeScreenViewmodel.selectedIndex,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: TabIcon(
                        icon: 'assets/icons/user (1) 3.png',
                        index: 3,
                        selectedIndex: homeScreenViewmodel.selectedIndex,
                      ),
                      label: '',
                    ),
                  ]),
            ),
          ),
          body: homeScreenViewmodel.tabs[homeScreenViewmodel.selectedIndex],
        );
      },
    );
  }
}

class TabIcon extends StatelessWidget {
  int selectedIndex;
  String icon;
  int index;
  TabIcon({
    required this.icon,
    required this.index,
    required this.selectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return selectedIndex == index
        ? Container(
            height: 60.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Image.asset(
              icon,
              color: AppColors.primaryColorLight,
            ),
          )
        : Image.asset(icon);
  }
}
