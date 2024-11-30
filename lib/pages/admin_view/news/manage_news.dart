import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/viewmodel/admin_product_requests.dart';
import 'package:mandisetu/widget/news_item_card.dart';
import 'package:mandisetu/widget/oops_error_widget.dart';
import 'package:provider/provider.dart';

class ManageNews extends StatefulWidget {
  const ManageNews({super.key});

  @override
  State<ManageNews> createState() => _ManageNewsState();
}

class _ManageNewsState extends State<ManageNews> {
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
              return const Center(
                child: CircularProgressIndicator(
                  color: StyleConstants.mediumGreen,
                ),
              );
            case Status.ERROR:
              return const OopsErrorWidget();
            case Status.COMPLETED:
              if (value.allNewsList.data!.news!.isEmpty) {
                return const Center(
                  child: Text('No news available yet!'),
                );
              }
              return RefreshIndicator(
                onRefresh: () async{
                  await provider.getNews();
                },
                child: ListView.separated(
                  itemCount: value.allNewsList.data!.news!.length,
                  padding: const EdgeInsets.all(15),
                  itemBuilder: (context, index) => InkWell(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Delete news?'),
                            content:
                                const Text('Are you sure you want to delete?'),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () async{
                                  await provider.deleteNews(context, value.allNewsList.data!.news![index].id);
                                  await provider.getNews();
                                },
                                child: const Text(' Sure '),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: NewsItemCard(
                      news: value.allNewsList.data!.news![index],
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                ),
              );

            case null:
              return const Text('Null');
          }
        },
      ),
    );
  }
}
