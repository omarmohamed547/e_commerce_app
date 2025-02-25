import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/cache/shared_pref.dart';
import 'package:e_commerce_app/core/utils/di/di.dart';
import 'package:e_commerce_app/core/utils/observer.dart';
import 'package:e_commerce_app/feature/auth/login/login_screen.dart';
import 'package:e_commerce_app/feature/auth/register/register_screen.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/product_tab_viewModel.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'feature/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures Flutter is fully initialized

  configureDependencies();
  Bloc.observer = MyBlocObserver();
  await SharedPrefernceUtilis.init();

  var token = SharedPrefernceUtilis.getData('token');
  String intialRoute =
      token == null ? AppRoutes.loginScreenId : AppRoutes.homeScreenId;
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => getIt<ProductTabViewmodel>())
    ],
    child: MyApp(
      intialRouteName: intialRoute,
    ),
  ));
}

class MyApp extends StatelessWidget {
  String intialRouteName;
  MyApp({super.key, required this.intialRouteName});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: intialRouteName,
        routes: {
          AppRoutes.productDetailsId: (context) => ProductDetails(),
          AppRoutes.loginScreenId: (context) => LoginScreen(),
          AppRoutes.registerScreenId: (context) => RegisterScreen(),
          AppRoutes.homeScreenId: (context) => HomeScreen(),
        },
      ),
    );
  }
}
