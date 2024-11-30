import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/model/purchase_request.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetails extends StatelessWidget {
  final Approved item;

  const OrderDetails({super.key, required this.item});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Trader details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: StyleConstants.darkGreen,
              ),
            ),
            const SizedBox(height: 10),
            keyValueItem(context, "Name :", item.user),
            Row(
              children: [
                Expanded(
                  child: keyValueItem(context, "Mobile no. :", item.phone),
                ),
                IconButton(
                  onPressed: () {
                    _makePhoneCall(item.phone!);
                  },
                  icon: const Icon(Icons.call),
                  style: IconButton.styleFrom(
                    backgroundColor:
                        StyleConstants.mediumGreen.withOpacity(0.2),
                    foregroundColor: StyleConstants.darkDarkGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Demand",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: StyleConstants.darkGreen,
              ),
            ),
            const SizedBox(height: 10),
            keyValueItem(
                context, "Product :", "${item.variety} - ${item.commodity}"),
            keyValueItem(
                context, "Quantity :", "${item.quantity} ${item.unit}"),
            keyValueItem(context, "Rate :", "₹${item.pricePerQuantity}"),
            const Row(
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                  flex: 2,
                  child: Divider(),
                ),
              ],
            ),
            keyValueItem(context, "Total :", "₹${item.amount}"),
            const SizedBox(height: 40),
            const Text(
              "Product details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: StyleConstants.darkGreen,
              ),
            ),
            const SizedBox(height: 10),
            keyValueItem(context, "Commodity :", item.commodity),
            keyValueItem(context, "Variety :", item.variety),
            keyValueItem(context, "Quality :", item.quality),
            const SizedBox(height: 30),
            const Text(
              "Wholesaler details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: StyleConstants.darkGreen,
              ),
            ),
            const SizedBox(height: 10),
            keyValueItem(
                context, "Location :", "${item.district}, ${item.state}"),
          ],
        ),
      ),
    );
  }

  Widget keyValueItem(BuildContext context, title, value) => Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      );
}
