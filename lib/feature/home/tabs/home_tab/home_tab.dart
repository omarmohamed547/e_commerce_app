import 'package:e_commerce_app/core/utils/app_style.dart';
import 'package:e_commerce_app/core/utils/custom_text_field.dart';
import 'package:e_commerce_app/core/utils/di/di.dart';
import 'package:e_commerce_app/domain/entities/category_or_brand_model.dart';
import 'package:e_commerce_app/feature/home/tabs/home_tab/cubit/home_tab_states.dart';
import 'package:e_commerce_app/feature/home/tabs/home_tab/cubit/home_tab_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeTabViewmodel homeTabViewmodel = getIt<HomeTabViewmodel>();

  @override
  void initState() {
    super.initState();
    homeTabViewmodel.getCategory();
    homeTabViewmodel.getBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: CustomTextField(
                          prefixIcon:
                              Image.asset("assets/icons/🦆 icon _search_.png"),
                          hintText: "what do you search for?"),
                    ),
                    Expanded(
                        flex: 2,
                        child: Image.asset(
                            "assets/icons/🦆 icon _shopping cart_.png"))
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 200.h,
                  width: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(24)),
                  child: ImageSlideshow(children: [
                    Image.asset(
                      'assets/images/unsolash1.png',
                      fit: BoxFit.fill,
                    ),
                    Image.asset(
                      'assets/images/unsplash2.png',
                      fit: BoxFit.fill,
                    ),
                    Image.asset(
                      'assets/images/unsplash3.png',
                      fit: BoxFit.fill,
                    ),
                  ]),
                ),
                SizedBox(
                  height: 13.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: AppStyle.bold20Black,
                    ),
                    Text("view all", style: AppStyle.Medium16Black)
                  ],
                ),
                SizedBox(
                  height: 13.h,
                ),
                BlocBuilder<HomeTabViewmodel, HomeTabStates>(
                  bloc: homeTabViewmodel,
                  builder: (context, state) {
                    if (state is FailureCategoriesState) {
                      return Text(state.error.errorMessage);
                    } else if (state is SuccessCategoriesState) {
                      print("category fetching");
                      return SizedBox(
                          // Use SizedBox instead of Expanded
                          height: 400.h,
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemCount: state.responseEntity.data!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return CategoryItem(
                                  category: state.responseEntity.data![index],
                                );
                              }));
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.grey,
                      ));
                    }
                  },
                ),
                SizedBox(
                  height: 13.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Brands",
                      style: AppStyle.bold20Black,
                    ),
                    Text("view all", style: AppStyle.Medium16Black)
                  ],
                ),
                BlocBuilder<HomeTabViewmodel, HomeTabStates>(
                  bloc: homeTabViewmodel,
                  builder: (context, state) {
                    if (state is FailureBrandsState) {
                      return Text(state.error.errorMessage);
                    } else if (state is SuccessBrandsState) {
                      print("Fetching brandsssssss"); // Debugging
                      return SizedBox(
                          height: 400,
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemCount: state.responseEntity.data!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return CategoryItem(
                                  category: state.responseEntity.data![index],
                                );
                              }));
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.grey,
                      ));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  DatumEntity category;
  CategoryItem({
    required this.category,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 144.h,
      width: 100.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center, // Centering content
        children: [
          ClipOval(
            child: CachedNetworkImage(
              width: 100.h, // Ensuring a perfect circle
              height: 100.h,
              fit: BoxFit.fill, // Ensures full image coverage
              imageUrl: category.image ?? "",
              placeholder: (context, url) =>
                  CircularProgressIndicator(color: Colors.grey),
              errorWidget: (context, url, error) => Icon(Icons.error, size: 50),
            ),
          ),
          SizedBox(height: 8.h), // Spacing between image and text
          SizedBox(
            width: 95.w, // Adjust width to avoid overflow
            child: Text(
              category.name ?? "",
              style: AppStyle.Medium16Black,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow
                  .ellipsis, // Ensures text does not exceed two lines
            ),
          ),
        ],
      ),
    );
  }
}
