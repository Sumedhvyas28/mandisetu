import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/pages/rates/analytics_detail.dart';
import 'package:mandisetu/viewmodel/commodity_viewmodel.dart';
import 'package:mandisetu/viewmodel/mandi_rates_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AllCommodity extends StatefulWidget {
  const AllCommodity({super.key});

  @override
  State<AllCommodity> createState() => _AllCommodityState();
}

class _AllCommodityState extends State<AllCommodity> {
  late CommodityViewModel commodityViewModel;

  @override
  void initState() {
    super.initState();
    commodityViewModel = CommodityViewModel();
    commodityViewModel.getCommodities();
  }

  Future<void> _handleRefresh() async {
    await commodityViewModel.getCommodities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Commodity'),
      ),
      body: ChangeNotifierProvider<CommodityViewModel>(
        create: (context) => commodityViewModel,
        child: Consumer<CommodityViewModel>(
          builder: (context, value, _) {
            switch (value.allCommoditiesList.status) {
              case Status.LOADING:
                return const Center(
                  child: CircularProgressIndicator(
                    color: StyleConstants.mediumGreen,
                  ),
                );
              case Status.ERROR:
                return Center(
                  child: Text(value.allCommoditiesList.message.toString()),
                );
              case Status.COMPLETED:
                return RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: GridView.builder(
                    itemCount: value.allCommoditiesList.data!.data!.length,
                    padding: const EdgeInsets.all(15),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 70,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.shade100.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: StyleConstants.darkGreen,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RatesByCommodity(
                                    commodity: value.allCommoditiesList.data!
                                        .data![index].name!,
                                  ),
                                ));
                          },
                          child: Center(
                            child: Text(
                              value.allCommoditiesList.data!.data![index].name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              default:
                return const Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }
}

// ======================================================================================================

class RatesByCommodity extends StatefulWidget {
  const RatesByCommodity({super.key, required this.commodity});

  final String commodity;

  @override
  State<RatesByCommodity> createState() => _RatesByCommodityState();
}

class _RatesByCommodityState extends State<RatesByCommodity> {
  MandiRatesViewModel mandiRatesViewModel = MandiRatesViewModel();

  @override
  void initState() {
    super.initState();
    mandiRatesViewModel.getAllMandiRates({"commodity_name": widget.commodity});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.commodity),
      ),

      body: ChangeNotifierProvider<MandiRatesViewModel>(
        create: (BuildContext context) => mandiRatesViewModel,
        child: Consumer<MandiRatesViewModel>(
          builder: (context, value, _) {
            switch (value.allMandiRates.status) {
              case Status.LOADING:
                return const SpinKitFadingCube(
                  size: 40,
                  color: StyleConstants.mediumGreen,
                );
              case Status.ERROR:
                return const SizedBox();
              case Status.COMPLETED:
                if (value.allMandiRates.data!.data!.isEmpty) {
                  return Center(child: Image.asset("assets/images/no_data.png", height: 200));
                }
                return ListView.builder(
                  itemCount: value.allMandiRates.data!.data!.length,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = value.allMandiRates.data!.data![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnalyticsDetails(commodity: widget.commodity,),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.district!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(fontWeight: FontWeight.w600),
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
    );
  }
}
