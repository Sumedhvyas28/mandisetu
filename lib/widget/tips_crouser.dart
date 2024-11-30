import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/viewmodel/admin_product_requests.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class TipsCarousel extends StatefulWidget {
  const TipsCarousel({super.key});

  @override
  State<TipsCarousel> createState() => _TipsCarouselState();
}

class _TipsCarouselState extends State<TipsCarousel> {
  AdminProductRequest bannerViewModel = AdminProductRequest();

  @override
  void initState() {
    super.initState();
    bannerViewModel.getBanners();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider<AdminProductRequest>(
      create: (BuildContext context) => bannerViewModel,
      child: Consumer<AdminProductRequest>(
        builder: (context, value, _) {
          switch (value.allBannerList.status) {
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

              if(value.allBannerList.data!.banner!.isEmpty) {
                return const SizedBox();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, bottom: 15, top: 10),
                    child: Text(
                      'Tips from successful traders',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 3.0,
                      enlargeCenterPage: false,
                    ),
                    items: value.allBannerList.data!.banner?.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: w,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: StyleConstants.darkGreen),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://stagging.jookwang.me/BannerImages/${imageUrl}',
                                fit: BoxFit.fitWidth,
                                width: MediaQuery.of(context).size.width,
                                placeholder: (context, url) =>
                                    const SpinKitPulse(
                                  size: 80,
                                  color: Colors.grey,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
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

