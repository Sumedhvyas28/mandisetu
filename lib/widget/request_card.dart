import 'package:flutter/material.dart';
import 'package:mandisetu/model/purchase_request.dart';
import 'package:mandisetu/pages/admin_view/orders/order_details.dart';

class RequestCard extends StatelessWidget {
  final Approved item;
  const RequestCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetails(
              item: item,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.greenAccent.shade100.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${item.user} demand for ${item.commodity} (${item.variety})',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(
                    '${item.quantity} ${item.unit} x ₹${item.pricePerQuantity}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
