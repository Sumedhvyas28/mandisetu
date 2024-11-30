import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';

class CropManaegementPage extends StatefulWidget {
  const CropManaegementPage({super.key});

  @override
  State<CropManaegementPage> createState() => _CropManaegementPageState();
}

class _CropManaegementPageState extends State<CropManaegementPage> {
  List<String> _neighborNames = [
    'Manager Name 1',
    'Manager Name 2',
    'Manager Name 3',
    'Manager Name 4',
    'Manager Name 5',
    'Manager Name 6',
    'Manager Name 7',
  ]; // Replace with actual data source (e.g., API, database)

  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Directory'),
        backgroundColor: StyleConstants.darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search button press (optional)
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by name...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (text) {
                  setState(() {
                    _searchText = text;
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _neighborNames.length,
                itemBuilder: (context, index) {
                  if (_searchText.isEmpty ||
                      _neighborNames[index]
                          .toLowerCase()
                          .contains(_searchText.toLowerCase())) {
                    return _buildNeighborCard(_neighborNames[index]);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeighborCard(String neighborName) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(
              'assets/profile/Memoji Boys.png'), // Replace with your neighbor's avatar image
        ),
        title: Text(neighborName),
        subtitle: Text('Address'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.call),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
