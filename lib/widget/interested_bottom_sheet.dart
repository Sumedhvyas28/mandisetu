import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/viewmodel/trader_viewmodel.dart';
import 'package:mandisetu/widget/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class InterestedBottomSheet extends StatefulWidget {
  const InterestedBottomSheet({super.key, required this.productId});

  final String productId;

  @override
  State<InterestedBottomSheet> createState() => _InterestedBottomSheetState();
}

class _InterestedBottomSheetState extends State<InterestedBottomSheet> {
  TextEditingController volume = TextEditingController();
  String? _selectedUnit;

  void _selectUnit(String unit) {
    setState(() {
      _selectedUnit = unit;
    });
  }

  Widget _buildUnit(String unit) {
    return GestureDetector(
      onTap: () => _selectUnit(unit),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(),
          color: _selectedUnit == unit ? Colors.green : Colors.transparent,
        ),
        child: Text(unit,
            style: TextStyle(
                color: _selectedUnit == unit ? Colors.white : Colors.black)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final traderProvider = Provider.of<TraderViewModel>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('How much volume you required??'),
          const SizedBox(height: 20),
          TextFormField(
            controller: volume,
            decoration: const InputDecoration(
              labelText: "Enter required volume",
              disabledBorder: InputBorder.none,
              labelStyle: TextStyle(color: Colors.black),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text('Total in : ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(width: 10),
              _buildUnit('Kg'),
              const SizedBox(width: 10),
              _buildUnit('Quintal'),
              const SizedBox(width: 10),
              _buildUnit('Ton'),
            ],
          ),

          const SizedBox(height: 50),

          traderProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                      color: StyleConstants.darkGreen),
                )
              : CustomElevatedButton(
                  onClick: () {
                    dynamic data = jsonEncode({
                      "product_id": widget.productId,
                      "quantity": volume.text,
                      "unit": _selectedUnit,
                    });
                    print(widget.productId);
                    print(volume.text);
                    print(_selectedUnit);
                    traderProvider.postInterested(context, data);
                  },
                  text: 'Send Request',
                ),
        ],
      ),
    );
  }
}
