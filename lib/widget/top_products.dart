import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/viewmodel/trader_viewmodel.dart';
import 'package:mandisetu/viewmodel/utils_provider.dart';
import 'package:mandisetu/widget/interested_bottom_sheet.dart';
import 'package:provider/provider.dart';

class TopProducts extends StatefulWidget {
  const TopProducts({super.key});

  @override
  State<TopProducts> createState() => _TopProductsState();
}

class _TopProductsState extends State<TopProducts> {
  TraderViewModel traderViewModel = TraderViewModel();

  @override
  void initState() {
    super.initState();
    traderViewModel.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TraderViewModel>(
      create: (context) => traderViewModel,
      child: Consumer<TraderViewModel>(
        builder: (context, value, _) {
          switch (value.allProductList.status) {
            case Status.LOADING:
              return const SizedBox();
            case Status.ERROR:
              return const SizedBox();
            case Status.COMPLETED:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: Text(
                      'Top sellers commodity on Mandisetu',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                  ),

                  GridView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(15),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 270,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final item = value.allProductList.data!.data![index];
                      return Material(
                        elevation: 2,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 130,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        'https://stagging.jookwang.me/ProductImages/${item.image![0]}',
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
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${item.varietyId} ${item.commodityId} for sale ${item.district}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        const SizedBox(height: 2),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.grey.shade300,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                '${item.district} ${item.state}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),

                                        Row(
                                          children: [
                                            Text(
                                              'Buying price',
                                              style: Theme.of(context).textTheme.labelSmall,
                                            ),
                                            const Spacer(),
                                            Text(
                                              '₹${item.rate}/Kg',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        // const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text(
                                              'Trade volume',
                                              style: Theme.of(context).textTheme.labelSmall,
                                            ),
                                            const Spacer(),
                                            Text(
                                              '${item.quantity} ${item.unit}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return InterestedBottomSheet(
                                        productId: item.id.toString(),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    color: StyleConstants.darkGreen,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    'Interested',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: () {
                      Provider.of<UtilsProvider>(context, listen: false)
                          .setCurrentIndex(1);
                    },
                    child: Center(
                      child: Container(
                        width: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'View all',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.red.shade400),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 5),
                            Icon(Icons.arrow_right_alt_rounded,
                                color: Colors.red.shade400)
                          ],
                        ),
                      ),
                    ),
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
