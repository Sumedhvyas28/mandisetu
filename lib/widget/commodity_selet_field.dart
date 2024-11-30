import 'package:flutter/material.dart';
import 'package:mandisetu/viewmodel/commodity_viewmodel.dart';
import 'package:mandisetu/widget/commodities_bottom_sheet.dart';
import 'package:provider/provider.dart';


class CommoditySelectField extends StatelessWidget {
  const CommoditySelectField({super.key});

  @override
  Widget build(BuildContext context) {
    final commodityProvider = Provider.of<CommodityViewModel>(context);

    return GestureDetector(
      onTap: (){
        // showModalBottomSheet(context: context, builder: (context) => CommoditiesBottomSheet(callBackFunction: (String selectedCommodity) {  },),);
      },
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.greenAccent.shade100.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text( commodityProvider.selectedCommodity == "" ? 'Commodity' : commodityProvider.selectedCommodity, style: Theme.of(context).textTheme.bodyLarge,),
            ),
          ],
        ),
      ),
    );
  }
}
