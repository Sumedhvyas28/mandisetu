import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/viewmodel/commodity_viewmodel.dart';
import 'package:provider/provider.dart';

import '../model/commodities.dart';

class CommoditiesBottomSheet extends StatefulWidget {
  const CommoditiesBottomSheet({super.key, required this.callBackFunction});

  final Function(Data selectedCommodity) callBackFunction;

  @override
  State<CommoditiesBottomSheet> createState() => _CommoditiesBottomSheetState();
}

class _CommoditiesBottomSheetState extends State<CommoditiesBottomSheet> {
  CommodityViewModel commodityViewModel = CommodityViewModel();

  @override
  void initState() {
    super.initState();
    commodityViewModel.getCommodities();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CommodityViewModel>(
      create: (context) => commodityViewModel,
      child: Consumer<CommodityViewModel>(
        builder: (context, value, _) {
          switch (value.allCommoditiesList.status) {
            case Status.LOADING:
              return const Center(
                child: CircularProgressIndicator(
                  color: StyleConstants.mediumGreen,
                ),
              );
            case Status.ERROR:
              return Text(value.allCommoditiesList.message.toString());
            case Status.COMPLETED:
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Select commodity',
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 15),
                      GridView.builder(
                        itemCount: value.allCommoditiesList.data!.data!.length,
                        // itemCount: 30,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          mainAxisExtent: 70,
                        ),
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.shade100.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 1, color: StyleConstants.darkGreen),
                          ),
                          child: InkWell(
                            onTap: () {
                              widget.callBackFunction(value.allCommoditiesList.data!.data![index]);
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Text(
                                value.allCommoditiesList.data!.data![index].name!,
                                // 'Commodity\n$index',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );

            case null:
              return const Text('Null');
          }
        },
      ),
    );
  }
}
