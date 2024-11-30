import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/widget/category/blogs.dart';
import 'package:mandisetu/widget/category/crop_care.dart';
import 'package:mandisetu/widget/category/faq.dart';
import 'package:mandisetu/widget/category/news.dart';
import 'package:mandisetu/widget/category/news_bullettin.dart';
import 'package:mandisetu/widget/category/weather.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool arrow_icon = false;

  final double initialHeight = 115.0;

  List<Map<String, String>> services = [
    {
      "title": "News Bullettin",
      "image":
          "https://www.iconpacks.net/icons/2/free-store-icon-2017-thumb.png",
    },
    {
      "title": "Blogs",
      "image": "https://cdn-icons-png.flaticon.com/512/2974/2974036.png",
    },
    {
      "title": "News",
      "image": "https://cdn-icons-png.flaticon.com/512/166/166258.png",
    },
    {
      "title": "Weather",
      "image": "https://cdn-icons-png.flaticon.com/512/2921/2921226.png",
    },
    {
      "title": "Crop Care",
      "image": "https://cdn-icons-png.flaticon.com/512/8524/8524310.png",
    },
    {
      "title": "Make FAQ",
      "image": "https://cdn-icons-png.flaticon.com/512/651/651009.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        _handleTap();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
      setState(() {
        arrow_icon = !arrow_icon;
      });
    } else {
      _controller.forward();
      setState(() {
        arrow_icon = !arrow_icon;
      });
    }
  }

  Future<void> _launchInWebView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  void openDetailPage(String name) {
    switch (name) {
      case 'News Bullettin':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewsBullettin()), // Replace with your page
        );
        break;
      case 'Blogs':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BlogsPage()), // Replace with your page
        );
        break;
      case 'News':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewsPages()), // Replace with your page
        );
        break;
      case 'Weather':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WeatherPage()), // Replace with your page
        );
        break;
      case 'Crop Care':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CropCarePage()), // Replace with your page
        );
        break;
      case 'Make FAQ':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FaqPage()), // Replace with your page
        );
        break;
      default:
        print('No matching page found');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    int itemCount = 6;
    int crossAxisCount = 4;
    double mainAxisExtent = 115.0;
    double gridHeight =
        (itemCount / crossAxisCount).ceil() * mainAxisExtent + 0;

    return GestureDetector(
      onTap: _handleTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    height: initialHeight +
                        (gridHeight - initialHeight) * _animation.value,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xffdcf9e3),
                      image: DecorationImage(
                        image: AssetImage('assets/images/category_png.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: GridView.builder(
                      itemCount: 6,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 97,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5,
                      ),
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                openDetailPage(services[index]['title']!);
                              },
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(50),
                                child: CircleAvatar(
                                  backgroundColor: Colors.greenAccent.shade100,
                                  radius: 25,
                                  child: Image.network(
                                    services[index]['image']!,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              services[index]['title']!,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 25),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/images/category_png.png'),
                    fit: BoxFit.cover),
              ),
              child: Icon(
                arrow_icon
                    ? CupertinoIcons.chevron_up_circle
                    : CupertinoIcons.chevron_down_circle,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:rsi/constants/color.dart';
// import 'package:rsi/data/response/status.dart';
// import 'package:rsi/view_models/category_view_model.dart';
// import 'package:rsi/views/news_view/new_list_view.dart';
// import 'package:rsi/views/strategies/all_strategy_list.dart';
//
// class CategoryCard extends StatefulWidget {
//   const CategoryCard({super.key});
//
//   @override
//   State<CategoryCard> createState() => _CategoryCardState();
// }
//
// class _CategoryCardState extends State<CategoryCard>
//     with SingleTickerProviderStateMixin {
//   CategoryViewModel categoryViewModel = CategoryViewModel();
//
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   bool arrow_icon = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     categoryViewModel.getCategory();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 400),
//     );
//     _animation = Tween<double>(begin: 0.5, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _handleTap() {
//     if (_controller.status == AnimationStatus.completed) {
//       _controller.reverse();
//       setState(() {
//         arrow_icon = !arrow_icon;
//       });
//     } else {
//       _controller.forward();
//       setState(() {
//         arrow_icon = !arrow_icon;
//       });
//     }
//   }
//
//
//   void openDetailPage(String name) {
//     switch (name) {
//       case 'Strategies' :
//             Navigator.push(context, MaterialPageRoute(builder: (context) => AllStrategyList(),));
//         break;
//       case 'News' :
//         Navigator.push(context, MaterialPageRoute(builder: (context) => NewsListView(),));
//         break;
//       default:
//         print('Hello');
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<CategoryViewModel>(
//       create: (BuildContext context) => categoryViewModel,
//       child: Consumer<CategoryViewModel>(
//         builder: (context, value, _) {
//           switch (value.categoryList.status) {
//             case Status.LOADING:
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             case Status.ERROR:
//               return Text(value.categoryList.message.toString());
//             case Status.COMPLETED:
//               if (value.categoryList.data!.isEmpty) {
//                 return const SizedBox();
//               }
//               return GestureDetector(
//                 onTap: _handleTap,
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         AnimatedBuilder(
//                           animation: _animation,
//                           builder: (context, child) {
//                             return Container(
//                               height: 230 * _animation.value,
//                               width: double.infinity,
//                               margin: const EdgeInsets.symmetric(
//                                   horizontal: 15),
//                               decoration: BoxDecoration(
//                                 color: letter_and_icons,
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               child: GridView.builder(
//                                 itemCount: value.categoryList.data!.length,
//                                 gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 4,
//                                   mainAxisExtent: 97,
//                                   crossAxisSpacing: 10,
//                                   mainAxisSpacing: 5,
//                                 ),
//                                 padding: const EdgeInsets.all(15),
//                                 itemBuilder: (context, index) {
//                                   return Column(
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           openDetailPage(value.categoryList.data![index].categoryName.toString());
//                                         },
//                                         child: Container(
//                                           width: 57,
//                                           // height: 53,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(
//                                                 22),
//                                             color: main_green,
//                                           ),
//                                           padding: const EdgeInsets.all(12),
//                                           child: Image.network(value
//                                               .categoryList.data![index].icon
//                                               .toString()),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 5),
//                                       Text(value.categoryList.data![index]
//                                           .categoryName.toString(), style: Theme
//                                           .of(context)
//                                           .textTheme
//                                           .titleSmall!
//                                           .copyWith(color: light_green),
//                                         textAlign: TextAlign.center,)
//                                     ],
//                                   );
//                                 },
//                               ),
//                             );
//                           },
//                         ),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       child: Container(
//                         height: 50,
//                         width: 50,
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle, color: letter_and_icons),
//                         child: Icon(
//                           arrow_icon
//                               ? CupertinoIcons.chevron_up_circle
//                               : CupertinoIcons.chevron_down_circle,
//                           color: light_green,
//                           size: 30,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               );
//
//             case null:
//               return Text('Null');
//           }
//         },
//       ),
//     );
//   }
// }
