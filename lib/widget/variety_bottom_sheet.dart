import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/viewmodel/commodity_viewmodel.dart';
import 'package:provider/provider.dart';

class VarietyBottomSheet extends StatefulWidget {
  const VarietyBottomSheet({super.key});

  @override
  State<VarietyBottomSheet> createState() => _VarietyBottomSheetState();
}

class _VarietyBottomSheetState extends State<VarietyBottomSheet> {
  CommodityViewModel commodityViewModel = CommodityViewModel();

  @override
  void initState() {
    super.initState();
    commodityViewModel.getVariety();
  }

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<CommodityViewModel>(
    //   create: (context) => commodityViewModel,
    //   child: Consumer<CommodityViewModel>(
    //     builder: (context, value, _) {
    //       switch (value.allVarietyList.status) {
    //         case Status.LOADING:
    //           return const Center(
    //             child: CircularProgressIndicator(
    //               color: StyleConstants.mediumGreen,
    //             ),
    //           );
    //         case Status.ERROR:
    //           return Text(value.allVarietyList.message.toString());
    //         case Status.COMPLETED:
    //           return SingleChildScrollView(
    //             child: Padding(
    //               padding: const EdgeInsets.all(15.0),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //
    //                   Text('Select variety', style: Theme.of(context).textTheme.headlineMedium),
    //
    //                   const SizedBox(height: 15),
    //
    //                   GridView.builder(
    //                     // itemCount: value.allCommoditiesList.data!.data!.length,
    //                     itemCount: 30,
    //                     shrinkWrap: true,
    //                     physics: NeverScrollableScrollPhysics(),
    //                     padding: EdgeInsets.zero,
    //                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //                         crossAxisCount: 3,
    //                         crossAxisSpacing: 10,
    //                         mainAxisSpacing: 20,
    //                         mainAxisExtent: 50),
    //                     itemBuilder: (context, index) => Container(
    //                       padding: const EdgeInsets.all(10),
    //                       decoration: BoxDecoration(
    //                         color: Colors.greenAccent.shade100.withOpacity(0.2),
    //                         borderRadius: BorderRadius.circular(5),
    //                         border: Border.all(width: 1, color: StyleConstants.darkGreen),
    //                       ),
    //                       child: InkWell(
    //                         onTap: () {
    //                           value.setSelectedCommodity(value.allVarietyList.data!.data![index].name!);
    //                           Navigator.pop(context);
    //                         },
    //                         child: Center(
    //                           child: Text(
    //                             value.allVarietyList.data!.data![index].name!,
    //                             // 'Commodity',
    //                             style: Theme.of(context)
    //                                 .textTheme
    //                                 .bodyMedium!
    //                                 .copyWith(fontWeight: FontWeight.w700),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           );
    //
    //         case null:
    //           return Text('Null');
    //       }
    //     },
    //   ),
    // );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text('Select variety', style: Theme.of(context).textTheme.headlineMedium),

            const SizedBox(height: 15),

            GridView.builder(
              // itemCount: value.allCommoditiesList.data!.data!.length,
              itemCount: 30,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 50),
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.shade100.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: StyleConstants.darkGreen),
                ),
                child: InkWell(
                  onTap: () {
                    // value.setSelectedCommodity(value.allVarietyList.data!.data![index].name!);
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Text(
                      'Variety $index',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
