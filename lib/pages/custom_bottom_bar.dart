import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mandisetu/pages/home/home_view.dart';
import 'package:mandisetu/pages/products/products_view.dart';
import 'package:mandisetu/pages/rates/rates_view.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/pages/trader_dashboard/trader_dashboard.dart';
import 'package:mandisetu/viewmodel/utils_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomTab extends StatefulWidget {
  const CustomBottomTab({super.key});

  @override
  State<CustomBottomTab> createState() => _CustomBottomTabState();
}

class _CustomBottomTabState extends State<CustomBottomTab> {

  final List<Widget> _screens = [
    const HomeView(),
    const ProductsView(),
    const RatesView(),
    TraderDashboardScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    final utilsProvider = Provider.of<UtilsProvider>(context);

    Widget _buildTabItem({required int index, required Widget icon, required String label}) {
      return Expanded(
        child: InkWell(
          onTap: () => utilsProvider.setCurrentIndex(index),
          borderRadius: BorderRadius.circular(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(height: 5),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfffdfdfd),
        body: _screens[utilsProvider.currentIndex],
        extendBody: true,
        bottomNavigationBar: BottomAppBar(
          height: 70,
          color: StyleConstants.darkDarkGreen,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildTabItem(
                index: 0,
                icon: Icon(
                  Icons.home,
                  color: utilsProvider.currentIndex == 0 ? Colors.white : Colors.white70,
                ),
                label: 'Home',
              ),
              _buildTabItem(
                index: 1,
                icon: Image.asset('assets/images/product_icon.png', color: utilsProvider.currentIndex == 1 ? Colors.white : Colors.white70, height: 20),
                label: 'Products',
              ),
              _buildTabItem(
                index: 2,
                icon: Icon(
                  Icons.auto_graph,
                  color: utilsProvider.currentIndex == 2 ? Colors.white : Colors.white70,
                ),
                label: 'Rates',
              ),
              _buildTabItem(
                index: 3,
                icon: Icon(
                  Icons.account_balance_wallet,
                  color: utilsProvider.currentIndex == 3 ? Colors.white : Colors.white70,
                ),
                label: 'Payments',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// floatingActionButton: FloatingActionButton(
//   onPressed: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => BuyAndSellForm()),
//     );
//   },
//   shape: const CircleBorder(),
//   backgroundColor: StyleConstants.darkDarkGreen,
//   child: const Icon(Icons.add, color: Colors.white),
// ),
// floatingActionButtonLocation: const FixedCenterDockedFabLocation(),

class FixedCenterDockedFabLocation extends FloatingActionButtonLocation {
  const FixedCenterDockedFabLocation({this.context});

  final BuildContext? context;

  @protected
  double getDockedY(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double contentBottom = scaffoldGeometry.contentBottom;
    final double bottomSheetHeight = scaffoldGeometry.bottomSheetSize.height;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    final double snackBarHeight = scaffoldGeometry.snackBarSize.height;
    final double bottomDistance =
        context != null ? MediaQuery.of(context!).viewInsets.bottom : 0;

    double fabY = contentBottom + bottomDistance - fabHeight / 2.0;

    // The FAB should sit with a margin between it and the snack bar.
    if (snackBarHeight > 0.0) {
      fabY = min(
        fabY,
        contentBottom -
            snackBarHeight -
            fabHeight -
            kFloatingActionButtonMargin,
      );
    }
    // The FAB should sit with its center in front of the top of the bottom sheet.
    if (bottomSheetHeight > 0.0) {
      fabY = min(fabY, contentBottom - bottomSheetHeight - fabHeight / 2.0);
    }

    final double maxFabY = scaffoldGeometry.scaffoldSize.height - fabHeight;
    return min(maxFabY, fabY);
  }

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = (scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width) /
        2.0;
    return Offset(fabX, getDockedY(scaffoldGeometry));
  }
}
