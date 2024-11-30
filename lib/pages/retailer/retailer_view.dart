import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/pages/retailer/dukandar_detail_view.dart';
import 'package:mandisetu/routes/route_constants.dart';
import 'package:mandisetu/viewmodel/trader_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../model/dukandar.dart';
import '../../widget/oops_error_widget.dart';

class RetailerView extends StatefulWidget {
  const RetailerView({super.key});

  @override
  State<RetailerView> createState() => _RetailerViewState();
}

class _RetailerViewState extends State<RetailerView> {
  TraderViewModel traderViewModel = TraderViewModel();


  @override
  void initState() {
    super.initState();
    traderViewModel.getAllDukandar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Sellers'),
        backgroundColor: StyleConstants.darkGreen,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: StyleConstants.darkGreen,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/shopkeeper.png',
                      height: 80,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Add new partner / seller',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, NamedRoutes.addNewSeller);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: StyleConstants.darkGreen,
                              ),
                              child: const Text('Add New Seller'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  SizedBox(width: 15),
                  Text('Your Sellers'),
                  SizedBox(width: 15),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 15),
              ChangeNotifierProvider<TraderViewModel>(
                create: (context) => traderViewModel,
                child: Consumer<TraderViewModel>(
                  builder: (context, value, _) {
                    switch (value.allDukandarOfTraderList.status) {
                      case Status.LOADING:
                        return const Center(
                          child: CircularProgressIndicator(
                            color: StyleConstants.mediumGreen,
                          ),
                        );
                      case Status.ERROR:
                        return const OopsErrorWidget();
                      case Status.COMPLETED:
                        return ListView.separated(
                          itemBuilder: (context, index) => sellerCard(
                              value.allDukandarOfTraderList.data!.data![index]),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: value.allDukandarOfTraderList.data!.data!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                        );

                      case null:
                        return const Text('Null');
                    }
                  },
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget sellerCard(Data data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DukandarDetailView(data: data),));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.greenAccent.shade100.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: StyleConstants.darkGreen),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey.shade300,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    const Icon(Icons.business, color: Colors.grey, size: 15),
                    const SizedBox(width: 10),
                    Text(data.shopName!),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey, size: 15),
                    const SizedBox(width: 10),
                    Text(data.address!),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
