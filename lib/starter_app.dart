import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:mandisetu/routes/route_constants.dart';
import 'package:mandisetu/routes/routes.dart';
import 'package:mandisetu/themes/themes.dart';
import 'package:mandisetu/viewmodel/auth_viewmodel.dart';
import 'package:mandisetu/viewmodel/commodity_viewmodel.dart';
import 'package:mandisetu/viewmodel/user_session.dart';
import 'package:mandisetu/viewmodel/utils_provider.dart';
import 'package:provider/provider.dart';

import 'viewmodel/admin_product_requests.dart';
import 'viewmodel/trader_viewmodel.dart';

class StarterApp extends StatelessWidget {
  const StarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CommodityViewModel()),
        ChangeNotifierProvider(create: (_) => TraderViewModel()),
        ChangeNotifierProvider(create: (_) => UtilsProvider()),
        ChangeNotifierProvider(create: (_) => UserSession()),
        ChangeNotifierProvider(create: (_) => AdminProductRequest()),
      ],
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: MaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          // ===================================
          debugShowCheckedModeBanner: false,
          title: 'StarterApp',
          theme: lightTheme,
          initialRoute: NamedRoutes.splash,
          routes: Routes.getRoutes(context),
        ),
      ),
    );
  }
}
