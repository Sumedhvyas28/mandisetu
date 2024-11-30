import 'package:flutter/material.dart';
import 'package:mandisetu/pages/auth/login_view.dart';
import 'package:mandisetu/pages/auth/register_view.dart';
import 'package:mandisetu/pages/custom_bottom_bar.dart';
import 'package:mandisetu/pages/profile/profile_view.dart';
import 'package:mandisetu/pages/retailer/add_new_contact.dart';
import 'package:mandisetu/pages/splash/splash_screen.dart';
import 'package:mandisetu/routes/route_constants.dart';


class Routes {
  static Map<String, WidgetBuilder> getRoutes(BuildContext context) {
    return {

      NamedRoutes.splash: (context) => const SplashScreen(),
      NamedRoutes.signup: (context) => RegisterView(),
      NamedRoutes.login: (context) => LoginView(),
      NamedRoutes.home: (context) => CustomBottomTab(),
      NamedRoutes.profile: (context) => ProfileView(),

      NamedRoutes.addNewSeller: (context) => AddNewRetailerContact(),
      NamedRoutes.bottomTab: (context) => CustomBottomTab(),


    };
  }
}
