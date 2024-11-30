import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/pages/profile/refer/pending.dart';
import 'package:mandisetu/pages/profile/refer/refer.dart';
import 'package:mandisetu/pages/profile/refer/reward.dart';

class ReferAndEarnPage extends StatefulWidget {
  const ReferAndEarnPage({super.key});

  @override
  State<ReferAndEarnPage> createState() => _ReferAndEarnPageState();
}

class _ReferAndEarnPageState extends State<ReferAndEarnPage> {
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
            _buildCard(
              icon: Icons.group_add,
              title: 'Invite and Earn',
              subtitle: 'Invite friends and earn rewards.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReferPage()),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            _buildCard(
                icon: Icons.card_giftcard,
                title: 'Community Rewards',
                subtitle: 'Claim benefits for growing the farmers network.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RewardPage()),
                  );
                }),
            SizedBox(
              height: 20,
            ),
            _buildCard(
                icon: Icons.hourglass_empty,
                title: 'Pending Connections',
                subtitle: 'View and manage incomplete farmer invites.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PendingPage()),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap, // Add this parameter
  }) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green[200],
          child: Icon(icon),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap, // Use ListTile's onTap
      ),
    );
  }
}
