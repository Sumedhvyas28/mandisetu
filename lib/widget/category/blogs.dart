import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({super.key});

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  // Dummy blog data
  final List<Map<String, String>> blogs = [
    {
      "title": "5 Tips for Growing Organic Vegetables",
      "description":
          "Discover effective techniques to cultivate organic vegetables in your garden for a healthier and greener lifestyle.",
      "image": "https://cdn-icons-png.flaticon.com/512/2274/2274195.png",
      "author": "Ramesh Kumar",
      "date": "12 Oct 2024"
    },
    {
      "title": "The Benefits of Seasonal Eating",
      "description":
          "Learn why eating seasonal vegetables can improve health, save money, and support local farmers.",
      "image": "https://cdn-icons-png.flaticon.com/512/2032/2032546.png",
      "author": "Anjali Gupta",
      "date": "10 Oct 2024"
    },
    {
      "title": "Top 10 High-Demand Vegetables in 2024",
      "description":
          "Stay ahead in the market by knowing which vegetables are trending and how you can meet the demand.",
      "image": "https://cdn-icons-png.flaticon.com/512/4315/4315210.png",
      "author": "Vivek Sharma",
      "date": "8 Oct 2024"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
        backgroundColor: StyleConstants.darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          final blog = blogs[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlogDetailsPage(blog: blog),
                ),
              );
            },
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Blog image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    child: Image.network(
                      blog['image']!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Blog content
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Blog title
                        Text(
                          blog['title']!,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: StyleConstants.darkGreen,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        // Blog description
                        Text(
                          blog['description']!,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.grey[700],
                                    height: 1.5,
                                  ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        // Blog metadata (author and date)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "By ${blog['author']}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.grey[600]),
                            ),
                            Text(
                              blog['date']!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.grey[600]),
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
        },
      ),
    );
  }
}

class BlogDetailsPage extends StatelessWidget {
  final Map<String, String> blog;

  const BlogDetailsPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog['title']!),
        backgroundColor: StyleConstants.darkGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              blog['image']!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              blog['title']!,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: StyleConstants.darkGreen,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              "By ${blog['author']} | ${blog['date']}",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              blog['description']! +
                  blog['description']! +
                  blog['description']! +
                  blog['description']! +
                  blog['description']! +
                  blog['description']! +
                  blog['description']!,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
