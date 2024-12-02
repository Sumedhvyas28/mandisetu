import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/viewmodel/admin_product_requests.dart';
import 'package:mandisetu/widget/oops_error_widget.dart';
import 'package:provider/provider.dart';

class ManageBannerTab extends StatefulWidget {
  ManageBannerTab({super.key});

  @override
  State<ManageBannerTab> createState() => _ManageBannerTabState();
}

class _ManageBannerTabState extends State<ManageBannerTab> {
  AdminProductRequest provider = AdminProductRequest();

  @override
  void initState() {
    super.initState();
    provider.getBanners();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminProductRequest>(
      create: (context) => provider,
      child: Consumer<AdminProductRequest>(
        builder: (context, value, _) {
          switch (value.allBannerList.status) {
            case Status.LOADING:
              return const Center(
                child: CircularProgressIndicator(
                  color: StyleConstants.mediumGreen,
                ),
              );
            case Status.ERROR:
              return const OopsErrorWidget();
            case Status.COMPLETED:
              if (value.allBannerList.data!.banner!.isEmpty) {
                return const Center(
                  child: Text('No banner image yet!'),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  await provider.getBanners();
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(15),
                  itemCount: value.allBannerList.data!.banner!.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "https://mandisetu.in/BannerImages/${value.allBannerList.data!.banner![index]}",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () async {
                              await provider.deleteBanner(context,
                                  value.allBannerList.data!.id![index]);
                              await provider.getBanners();
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(5),
                              child: const Icon(
                                Icons.delete_forever,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
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
