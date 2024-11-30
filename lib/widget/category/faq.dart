import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  // Dummy FAQ data
  final List<Map<String, String>> faqList = [
    {
      "question": "How can I buy vegetables on this platform?",
      "answer":
          "You can browse the available vegetables, add them to your cart, and proceed to checkout."
    },
    {
      "question": "What payment methods are accepted?",
      "answer":
          "We accept UPI, credit/debit cards, net banking, and cash on delivery."
    },
    {
      "question": "Can I track my order?",
      "answer": "Yes, you can track your order in the 'My Orders' section."
    },
    {
      "question": "What are the delivery charges?",
      "answer":
          "Delivery charges vary based on the order amount and your location. Orders above ₹500 are eligible for free delivery."
    },
    {
      "question": "How can I contact customer support?",
      "answer":
          "You can reach out to us through the 'Contact Us' section in the app or call our helpline at 1800-123-456."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
        backgroundColor: StyleConstants.darkGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: faqList.length,
          itemBuilder: (context, index) {
            final faq = faqList[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ExpansionTile(
                title: Text(
                  faq['question']!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      faq['answer']!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
