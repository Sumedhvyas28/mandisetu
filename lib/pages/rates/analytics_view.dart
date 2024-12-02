import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/model/static_rate_product.dart';
import 'package:mandisetu/pages/rates/analytics_detail.dart';
import 'package:mandisetu/viewmodel/mandi_rates_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key, required this.item});

  final Data item;

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  MandiRatesViewModel mandiRatesViewModel = MandiRatesViewModel();

  @override
  void initState() {
    super.initState();
    mandiRatesViewModel
        .getAllMandiRates({"commodity_name": "${widget.item.commodity}"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.commodity!),
        backgroundColor: StyleConstants.darkDarkGreen,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            topBanner(),
            ChangeNotifierProvider<MandiRatesViewModel>(
              create: (BuildContext context) => mandiRatesViewModel,
              child: Consumer<MandiRatesViewModel>(
                builder: (context, value, _) {
                  switch (value.allMandiRates.status) {
                    case Status.LOADING:
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[200]!,
                        highlightColor: Colors.white,
                        child: Container(
                          height: 120,
                          margin: const EdgeInsets.symmetric(horizontal: 35),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.grey[350]!,
                          ),
                        ),
                      );
                    case Status.ERROR:
                      return const SizedBox();
                    case Status.COMPLETED:
                      if (value.allMandiRates.data!.data!.isEmpty) {
                        return const SizedBox();
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.allMandiRates.data!.data!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = value.allMandiRates.data!.data![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AnalyticsDetails(
                                      commodity: widget.item.commodity!,
                                    ),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Colors.green.shade100.withOpacity(0.5),
                                    radius: 15,
                                    child: const Icon(
                                      Icons.location_on_rounded,
                                      size: 20,
                                      color: StyleConstants.darkGreen,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.district!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 8),
                                        // Text(
                                        //   'Rate on 10/Aug/2024',
                                        //   style: Theme.of(context).textTheme.labelMedium,
                                        // ),
                                        Text(
                                          '₹${data.price}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                            'Min ₹${data.minPrice} - Max ₹${data.maxPrice}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium),
                                        const SizedBox(height: 5),
                                        Container(
                                          height: 0.5,
                                          width: double.infinity,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );

                    case null:
                      return Text('Null');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget topBanner() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://wallpapers.com/images/hd/light-green-background-7y4uwih3tsy6two2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                  "https://mandisetu.in/StaticImage/${widget.item.image}"),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.commodity!,
                  style: const TextStyle(
                    color: StyleConstants.darkDarkGreen,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 18,
                      color: StyleConstants.darkDarkGreen,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '1378 Mandis',
                      style: TextStyle(
                        color: StyleConstants.darkDarkGreen,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Rate/Quintal',
                  style: TextStyle(
                      color: StyleConstants.darkDarkGreen, fontSize: 12),
                ),
                FittedBox(
                  child: Text(
                    'Min ₹${widget.item.minPrice}\nMax ₹${widget.item.maxPrice}',
                    style: const TextStyle(
                        color: StyleConstants.darkDarkGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
