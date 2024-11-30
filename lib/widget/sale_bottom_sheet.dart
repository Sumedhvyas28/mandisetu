import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/viewmodel/trader_viewmodel.dart';
import 'package:mandisetu/widget/commodity_selet_field.dart';
import 'package:mandisetu/widget/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class DukandarSaleBottomSheet extends StatefulWidget {
  const DukandarSaleBottomSheet({super.key, required this.dukandarId});

  final String dukandarId;

  @override
  State<DukandarSaleBottomSheet> createState() =>
      _DukandarSaleBottomSheetState();
}

class _DukandarSaleBottomSheetState extends State<DukandarSaleBottomSheet> {
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

          const CommoditySelectField(),

          const SizedBox(height: 15),

          TextFormField(
            controller: volume,
            decoration: const InputDecoration(
              labelText: "Enter required volume",
              disabledBorder: InputBorder.none,
              labelStyle: TextStyle(color: Colors.black),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 15),

          TextFormField(
            controller: volume,
            decoration: const InputDecoration(
              labelText: "Enter rate per unit",
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
                      "dukandar_id": "1",
                      "product_id": "3",
                      "quantity": "10",
                      "unit": "kg",
                      "price_per_unit" : "30"
                    });
                    traderProvider.addSales(context, data);
                  },
                  text: 'Send Request',
                ),
        ],
      ),
    );
  }
}
