import 'package:flutter/material.dart';
import 'package:mandisetu/pages/admin_view/banner_promotion/manage_banner_tab.dart';
import 'package:mandisetu/pages/admin_view/news/create_news.dart';
import 'package:mandisetu/pages/admin_view/news/manage_news.dart';

class NewsUpdates extends StatefulWidget {
  const NewsUpdates({super.key});

  @override
  State<NewsUpdates> createState() => _NewsUpdatesState();
}

class _NewsUpdatesState extends State<NewsUpdates> {

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
              Tab(text: 'New News'),
              Tab(text: 'Manage News'),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            CreateNews(),
            ManageNews(),
          ],
        ),

      ),
    );
  }
}


