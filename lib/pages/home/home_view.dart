import 'package:flutter/material.dart';
import 'package:mandisetu/viewmodel/trader_viewmodel.dart';
import 'package:mandisetu/widget/blogs_widget.dart';
import 'package:mandisetu/widget/category_card.dart';
import 'package:mandisetu/widget/main_header.dart';
import 'package:mandisetu/widget/mandi_price.dart';
import 'package:mandisetu/widget/tips_crouser.dart';
import 'package:mandisetu/widget/top_products.dart';

// 1 st icon bottom navbaritem

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TraderViewModel traderViewModel = TraderViewModel();

  @override
  void initState() {
    super.initState();
    traderViewModel.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        MainHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CategoryCard(),
                SizedBox(height: 15),
                TopProducts(),
                SizedBox(height: 20),
                MandiPrice(),
                TipsCarousel(),
                SizedBox(height: 10),
                BlogsWidget(),
                SizedBox(height: 100)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
