import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: StyleConstants.darkGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top section with total amount and people
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTopCard(
                  icon: Icons.person_add_alt_1,
                  title: 'Total Amount',
                  value: '₹500/-',
                ),
                _buildTopCard(
                  icon: Icons.group,
                  title: 'Total People',
                  value: '03',
                ),
              ],
            ),
            SizedBox(height: 16.0),
            // List of referred people
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Replace with actual data
                itemBuilder: (context, index) {
                  return _buildReferredPersonCard(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 40.0),
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferredPersonCard(int index) {
    return Card(
      elevation: 4,
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(
              'assets/profile/Memoji Boys.png'), // Replace with actual avatar
        ),
        title: Text('Person Name'),
        subtitle: Text('₹250 | 02-08-2024'),
        trailing: ElevatedButton(
          onPressed: () {},
          child: Text('Rewarded'),
        ),
      ),
    );
  }
}
