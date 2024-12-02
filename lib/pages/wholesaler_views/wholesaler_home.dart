import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/pages/buy_sell/buy_sell_form.dart';
import 'package:mandisetu/viewmodel/trader_viewmodel.dart';
import 'package:mandisetu/widget/locating/product_loding.dart';
import 'package:mandisetu/widget/logout_header.dart';
import 'package:mandisetu/widget/oops_error_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:mandisetu/pages/image/full_screen_img.dart';

import '../../model/product.dart';

class WholesalerHomeView extends StatefulWidget {
  const WholesalerHomeView({super.key});

  @override
  State<WholesalerHomeView> createState() => _WholesalerHomeViewState();
}

class _WholesalerHomeViewState extends State<WholesalerHomeView> {
  TraderViewModel traderViewModel = TraderViewModel();

  @override
  void initState() {
    super.initState();
    traderViewModel.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff0f0f3),
        body: RefreshIndicator(
          onRefresh: () async {
            await traderViewModel.getAllProducts();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const LogoutHeader(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BuyAndSellForm(),
                        ));
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.shade100.withOpacity(0.2),
                      border: Border.all(color: Colors.green, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_circle,
                            size: 30, color: Colors.green),
                        const SizedBox(height: 15),
                        Text(
                          'Add new product for sell',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                  ),
                ),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    SizedBox(width: 10),
                    Text('Your Live Products'),
                    SizedBox(width: 10),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 15),
                ChangeNotifierProvider<TraderViewModel>(
                  create: (context) => traderViewModel,
                  child: Consumer<TraderViewModel>(
                    builder: (context, value, _) {
                      switch (value.allProductList.status) {
                        case Status.LOADING:
                          return ListView.builder(
                            itemCount: 3,
                            itemBuilder: (context, index) =>
                                const ProductLoading(),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          );
                        case Status.ERROR:
                          return const OopsErrorWidget();
                        case Status.COMPLETED:
                          return ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item =
                                  value.allProductList.data!.data![index];
                              return TraderProductCard(data: item);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 15),
                            itemCount: value.allProductList.data!.data!.length,
                          );

                        case null:
                          return Text('Null');
                      }
                    },
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TraderProductCard extends StatelessWidget {
  const TraderProductCard({super.key, required this.data});

  final Data data;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TraderViewModel>(context);

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.greenAccent.shade100.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 160,
              width: 150,
              child: CarouselSlider.builder(
                unlimitedMode: true,
                slideBuilder: (index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenImage(
                            imageUrl:
                                'https://mandisetu.in/ProductImages/${data.image![index]}',
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://mandisetu.in/ProductImages/${data.image![index]}',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        placeholder: (context, url) => const SpinKitPulse(
                          size: 80,
                          color: Colors.grey,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          "assets/images/placeholder.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
                slideTransform: const CubeTransform(),
                slideIndicator: CircularSlideIndicator(
                  padding: const EdgeInsets.only(bottom: 10),
                  indicatorRadius: 2,
                  itemSpacing: 10,
                ),
                itemCount: data.image!.length,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '${data.varietyId} ${data.commodityId} for sale ${data.district}',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color(0xff3A9046),
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        data.state ?? "No state define",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: const Color(0xff3A9046),
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Buying price',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Spacer(),
                      Text(
                        '₹${data.rate}/Kg',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Trade volume',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Spacer(),
                      Text(
                        '${data.quantity} ${data.unit}',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit_rounded),
                        style: IconButton.styleFrom(
                          backgroundColor: StyleConstants.darkGreen,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          print(data.id);
                          provider.deleteWholesalerProduct(context, data.id);
                        },
                        icon: const Icon(Icons.delete_rounded),
                        style: IconButton.styleFrom(
                          backgroundColor: StyleConstants.darkGreen,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
