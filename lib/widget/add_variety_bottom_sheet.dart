import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mandisetu/utils/Utils.dart';
import 'package:mandisetu/viewmodel/commodity_viewmodel.dart';
import 'package:mandisetu/widget/commodities_bottom_sheet.dart';
import 'package:mandisetu/widget/custom_elevated_button.dart';
import 'package:provider/provider.dart';

import '../model/commodities.dart';

class AddVarietyBottomSheet extends StatefulWidget {
  const AddVarietyBottomSheet({super.key});

  @override
  State<AddVarietyBottomSheet> createState() => _AddVarietyBottomSheetState();
}

class _AddVarietyBottomSheetState extends State<AddVarietyBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commodityController = TextEditingController(text: "Select commodity");
  final TextEditingController _commodityId = TextEditingController();

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
            'Add new variety',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => CommoditiesBottomSheet(
                  callBackFunction: (Data selectedCommodity) async {
                    setState(() {
                      _commodityController.text = selectedCommodity.name!;
                      _commodityId.text = selectedCommodity.id.toString();
                    });
                  },
                ),
              );
            },
            child: Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.greenAccent.shade100.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      _commodityController.text,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Variety name',
            ),
          ),
          const Spacer(),
          commodityProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CustomElevatedButton(
                  onClick: () {

                    if(_commodityId.text.isEmpty || _nameController.text.isEmpty){
                      Utils.errorSnackBar("Please enter required field", context);
                      return;
                    }

                    dynamic data = jsonEncode({
                      "commodity_id": _commodityId.text,
                      "name": _nameController.text,
                    });
                    commodityProvider.addNewVariety(context, data);
                  },
                  text: 'SUBMIT',
                ),
        ],
      ),
    );
  }
}
