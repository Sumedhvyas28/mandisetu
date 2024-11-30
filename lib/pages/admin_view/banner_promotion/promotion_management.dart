import 'package:flutter/material.dart';
import 'package:mandisetu/pages/admin_view/banner_promotion/manage_banner_tab.dart';
import 'package:mandisetu/pages/admin_view/banner_promotion/new_banner_tab.dart';

class PromotionManagement extends StatefulWidget {
  const PromotionManagement({super.key});

  @override
  State<PromotionManagement> createState() => _PromotionManagementState();
}

class _PromotionManagementState extends State<PromotionManagement> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Banner'),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'New Banner'),
              Tab(text: 'Manage Banners'),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            const NewBannerTab(),
            ManageBannerTab(),
          ],
        ),

      ),
    );
  }
}


