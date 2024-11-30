import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mandisetu/pages/admin_view/orders/approved_tab.dart';
import 'package:mandisetu/pages/admin_view/orders/cancel_request_tab.dart';
import 'package:mandisetu/pages/admin_view/orders/pending_tab.dart';
import 'package:mandisetu/pages/admin_view/orders/reject_request_tab.dart';
import 'package:mandisetu/viewmodel/admin_product_requests.dart';
import 'package:provider/provider.dart';

class VyapariPurchases extends StatefulWidget {
  const VyapariPurchases({super.key});

  @override
  State<VyapariPurchases> createState() => _VyapariPurchasesState();
}

class _VyapariPurchasesState extends State<VyapariPurchases> {

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<AdminProductRequest>(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Orders'),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Purchase Request'),
              Tab(text: 'Approved'),
              Tab(text: 'Cancel request'),
              Tab(text: 'Reject'),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            PendingRequestTab(),
            ApprovedRequestTab(),
            CancelRequestTab(),
            RejectRequestTab(),
          ],
        ),
      ),
    );
  }

}


