import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/pages/image/full_screen_img.dart';
import 'package:mandisetu/viewmodel/trader_viewmodel.dart';
import 'package:mandisetu/widget/custom_elevated_button.dart';
import 'package:mandisetu/widget/interested_bottom_sheet.dart';
import 'package:mandisetu/widget/locating/product_loding.dart';
import 'package:mandisetu/widget/main_header.dart';
import 'package:mandisetu/widget/oops_error_widget.dart';
import 'package:provider/provider.dart';

import '../../model/product.dart';

// 2 nd bottom nav bar item

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  TraderViewModel traderViewModel = TraderViewModel();

  @override
  void initState() {
    super.initState();
    traderViewModel.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MainHeader(),
        ChangeNotifierProvider<TraderViewModel>(
          create: (context) => traderViewModel,
          child: Consumer<TraderViewModel>(
            builder: (context, value, _) {
              switch (value.allProductList.status) {
                case Status.LOADING:
                  return ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) => ProductLoading(),
                    shrinkWrap: true,
                  );
                case Status.ERROR:
                  return const OopsErrorWidget();
                case Status.COMPLETED:
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item =
                                  value.allProductList.data!.data![index];
                              return CustomCard2(context, item);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 15),
                            itemCount: 4,
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  );

                case null:
                  return Text('Null');
              }
            },
          ),
        ),
      ],
    );
  }

  Widget CustomCard2(BuildContext context, Data data) {
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
                      const Icon(Icons.location_on,
                          color: Color(0xff3A9046), size: 18),
                      const SizedBox(width: 6),
                      Text(
                        data.state ?? "No location",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: const Color(0xff3A9046)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return InterestedBottomSheet(
                            productId: data.id.toString(),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      decoration: BoxDecoration(
                        color: StyleConstants.darkGreen,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Interested',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
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
