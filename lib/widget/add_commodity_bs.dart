import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mandisetu/viewmodel/commodity_viewmodel.dart';
import 'package:mandisetu/widget/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class AddCommodityBottomSheet extends StatefulWidget {
  AddCommodityBottomSheet({super.key});

  @override
  State<AddCommodityBottomSheet> createState() => _AddCommodityBottomSheetState();
}

class _AddCommodityBottomSheetState extends State<AddCommodityBottomSheet> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final commodityProvider = Provider.of<CommodityViewModel>(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add new commodity',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Commodity name',
            ),
          ),
          const Spacer(),
          commodityProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CustomElevatedButton(
                  onClick: () {
                    dynamic data = jsonEncode({"name": _nameController.text});
                    commodityProvider.addNewCommodity(context, data);
                  },
                  text: 'SUBMIT',
                ),
        ],
      ),
    );
  }
}
