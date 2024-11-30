import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/viewmodel/admin_product_requests.dart';
import 'package:mandisetu/widget/news_item_card.dart';
import 'package:provider/provider.dart';

class BlogsWidget extends StatefulWidget {
  const BlogsWidget({super.key});

  @override
  State<BlogsWidget> createState() => _BlogsWidgetState();
}

class _BlogsWidgetState extends State<BlogsWidget> {
  AdminProductRequest provider = AdminProductRequest();

  @override
  void initState() {
    super.initState();
    provider.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminProductRequest>(
      create: (context) => provider,
      child: Consumer<AdminProductRequest>(
        builder: (context, value, _) {
          switch (value.allNewsList.status) {
            case Status.LOADING:
              return const SizedBox();
            case Status.ERROR:
              return const SizedBox();
            case Status.COMPLETED:
              if (value.allNewsList.data!.news!.isEmpty) {
                return const Center(
                  child: Text('No news available yet!'),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, bottom: 5, top: 15),
                    child: Text(
                      'News',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 240,
                    child: ListView.separated(
                      itemCount: value.allNewsList.data!.news!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NewsItemCard(
                          news: value.allNewsList.data!.news![index],
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                    ),
                  ),
                ],
              );

            case null:
              return const Text('Null');
          }
        },
      ),
    );
  }
}
