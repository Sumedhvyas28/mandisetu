import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';

class NewsPages extends StatefulWidget {
  const NewsPages({super.key});

  @override
  State<NewsPages> createState() => _NewsPagesState();
}

class _NewsPagesState extends State<NewsPages> {
  // Dummy data for news items
  final List<Map<String, dynamic>> categories = [
    {
      "category": "Price Updates",
      "news": [
        {
          "title": "Carrot Prices Drop by 15%",
          "description":
              "Carrot prices have seen a notable decrease due to an abundant harvest in northern regions.",
          "image": "https://cdn-icons-png.flaticon.com/512/135/135620.png",
          "date": "30 Nov 2024"
        },
        {
          "title": "Capsicum Prices Stable",
          "description":
              "Capsicum prices remain unchanged for the fourth consecutive week, ensuring consistency for buyers.",
          "image": "https://cdn-icons-png.flaticon.com/512/1141/1141712.png",
          "date": "29 Nov 2024"
        },
      ],
    },
    {
      "category": "Market Trends",
      "news": [
        {
          "title": "Organic Vegetables Demand Rises",
          "description":
              "The popularity of organic produce is driving demand, with an increase of 20% in the last month.",
          "image": "https://cdn-icons-png.flaticon.com/512/3081/3081997.png",
          "date": "28 Nov 2024"
        },
        {
          "title": "Local Farmers’ Market Gaining Traction",
          "description":
              "Local farmers’ markets are seeing a surge in footfall, creating new opportunities for small-scale sellers.",
          "image": "https://cdn-icons-png.flaticon.com/512/3163/3163642.png",
          "date": "27 Nov 2024"
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        backgroundColor: StyleConstants.darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category title
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  category['category'],
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: StyleConstants.darkGreen,
                      ),
                ),
              ),
              // News items for this category
              Column(
                children: (category['news'] as List<Map<String, String>>)
                    .map((newsItem) => Card(
                          color: Colors.white,
                          elevation: 4,
                          margin: const EdgeInsets.only(bottom: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            children: [
                              // Image section
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  bottomLeft: Radius.circular(15.0),
                                ),
                                child: Image.network(
                                  newsItem['image']!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // News content section
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newsItem['title']!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: StyleConstants.darkGreen,
                                            ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        newsItem['description']!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.grey[700]),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        newsItem['date']!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}
