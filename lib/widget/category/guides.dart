import 'package:flutter/material.dart';

// Placeholder for StyleConstants
class StyleConstants {
  static const Color darkGreen = Color(0xFF2E7D32);
}

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  // Dummy data for products/guides
  final List<Map<String, String>> productList = [
    {
      "image": "assets/images/no_data.png",
      "title": "Fresh Tomatoes",
      "price": "₹40/kg",
      "rating": "4.5"
    },
    {
      "image": "assets/images/no_data.png",
      "title": "Organic Carrots",
      "price": "₹50/kg",
      "rating": "4.7"
    },
    {
      "image": "assets/images/no_data.png",
      "title": "Green Spinach",
      "price": "₹30/kg",
      "rating": "4.2"
    },
    {
      "image": "assets/images/no_data.png",
      "title": "Cabbage",
      "price": "₹35/kg",
      "rating": "4.3"
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // Filtered product list based on search query
    final filteredProducts = productList.where((product) {
      final title = product['title']!.toLowerCase();
      return title.contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guides'),
        backgroundColor: StyleConstants.darkGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Field
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search guides...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            // Grid View
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GuideDetailsPage(
                            title: product['title']!,
                            image: product['image']!,
                            price: product['price']!,
                            rating: product['rating']!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0),
                            ),
                            child: Image.asset(
                              product['image']!,
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          // Product Title
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              product['title']!,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          // Product Price
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              product['price']!,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          // Rating (Stars)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  product['rating']!,
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GuideDetailsPage extends StatelessWidget {
  final String title;
  final String price;
  final String rating;
  final String image;

  const GuideDetailsPage({
    super.key,
    required this.title,
    required this.price,
    required this.rating,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    // Placeholder data
    final String date = "24 Nov, 2024";
    final String description = "This is a detailed description of the guide.";

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: StyleConstants.darkGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: StyleConstants.darkGreen,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black),
            ),
            const SizedBox(height: 16),
            Text(
              description +
                  description +
                  description +
                  description +
                  description +
                  description +
                  description +
                  description +
                  description,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}
