import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/pages/rates/all_commodities.dart';
import 'package:mandisetu/pages/rates/analytics_view.dart';
import 'package:mandisetu/viewmodel/mandi_rates_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MandiPrice extends StatefulWidget {
  const MandiPrice({super.key});

  @override
  State<MandiPrice> createState() => _MandiPriceState();
}

class _MandiPriceState extends State<MandiPrice> {
  MandiRatesViewModel mandiRatesViewModel = MandiRatesViewModel();

  @override
  void initState() {
    super.initState();
    mandiRatesViewModel.getStaticRateProduct();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MandiRatesViewModel>(
      create: (BuildContext context) => mandiRatesViewModel,
      child: Consumer<MandiRatesViewModel>(
        builder: (context, value, _) {
          switch (value.allStaticProducts.status) {
            case Status.LOADING:
              return Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.white,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[350]!,
                ),
              );
            case Status.ERROR:
              // return const SizedBox();
              return Column(
                children: [
                  Container(
                    height: 280,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xffdcf9e3),
                      image: DecorationImage(
                          image: AssetImage('assets/images/mandi_price_bg.png'), fit: BoxFit.cover),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [

                          Container(
                            width: 140,
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Mandi\nPrice',
                              style: GoogleFonts.anton(
                                fontSize: 40,
                                // fontWeight: FontWeight.w900,
                                color: StyleConstants.darkDarkGreen,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AllCommodity(),));
                            },
                            child: Container(
                              height: 240,
                              width: 150,
                              decoration: BoxDecoration(
                                // color: const Color(0xffdcf9e3),
                                color: Colors.white30,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.arrow_circle_right_outlined, size: 30),
                                  SizedBox(height: 8),
                                  Text("More"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    color: StyleConstants.darkDarkGreen,
                    child: Center(
                        child: Text(
                          'Get daily updated/realtime mandi rates',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.white),
                        )),
                  ),
                ],
              );
            case Status.COMPLETED:
              if (value.allStaticProducts.data!.data!.isEmpty) {
                return const SizedBox();
              }

              return Column(
                children: [
                  Container(
                    height: 280,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xffdcf9e3),
                      image: DecorationImage(
                          image: AssetImage('assets/images/mandi_price_bg.png'),
                          fit: BoxFit.cover),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            width: 140,
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Mandi\nPrice',
                              style: GoogleFonts.anton(
                                fontSize: 40,
                                // fontWeight: FontWeight.w900,
                                color: StyleConstants.darkDarkGreen,
                              ),
                            ),
                          ),
                          Container(
                            height: 240,
                            // color: const Color(0xffdcf9e3),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: mandiRatesViewModel.allStaticProducts.data!.data!.length,
                              itemBuilder: (context, index) {
                                final item = mandiRatesViewModel.allStaticProducts.data!.data![index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AnalyticsView(item: item),
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        height: 250,
                                        width: 150,
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          // border: Border.all(color: dar)
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 130,
                                              width: double.infinity,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Image.network(
                                                  'https://stagging.jookwang.me/StaticImage/${item.image}',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),

                                            const SizedBox(height: 5),

                                            Text(
                                              item.commodity!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),

                                            const Expanded(child: SizedBox()),

                                            SizedBox(
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "₹${item.minPrice} - ₹${item.maxPrice}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                  ),
                                                  Text(
                                                    'Rate/Quintal',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 10),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AllCommodity(),));
                            },
                            child: Container(
                              height: 220,
                              width: 150,
                              decoration: BoxDecoration(
                                // color: const Color(0xffdcf9e3),
                                  color: Colors.white30,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.arrow_circle_right_outlined, size: 30),
                                  SizedBox(height: 8),
                                  Text("More"),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),

                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    color: StyleConstants.darkDarkGreen,
                    child: Center(
                        child: Text(
                      'Get daily updated/realtime mandi rates',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.white),
                    )),
                  ),
                ],
              );

            case null:
              return Text('Null');
          }
        },
      ),
    );
  }
}
