import 'package:flutter/material.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/viewmodel/commodity_viewmodel.dart';
import 'package:provider/provider.dart';

import '../constants/style/style_constants.dart';
import '../model/commodities.dart';

class CommodityVarietyItem extends StatefulWidget {
  const CommodityVarietyItem({super.key, required this.data});

  final Data data;

  @override
  State<CommodityVarietyItem> createState() => _CommodityVarietyItemState();
}

class _CommodityVarietyItemState extends State<CommodityVarietyItem> {
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isOpened = !isOpened;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.greenAccent.shade100.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: StyleConstants.darkGreen),
            ),
            child: Row(
              children: [
                const SizedBox(width: 15),
                Text(
                  widget.data.name!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        if (isOpened) VarietyWidget(id: widget.data.id),
      ],
    );
  }
}

class VarietyWidget extends StatefulWidget {
  const VarietyWidget({super.key, this.id});

  final dynamic id;

  @override
  State<VarietyWidget> createState() => _VarietyWidgetState();
}

class _VarietyWidgetState extends State<VarietyWidget> {
  late CommodityViewModel commodityViewModel;

  @override
  void initState() {
    super.initState();
    commodityViewModel = CommodityViewModel();
    commodityViewModel.getCommodityVariety(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CommodityViewModel>(
      create: (context) => commodityViewModel,
      child: Consumer<CommodityViewModel>(
        builder: (context, value, _) {
          switch (value.allVarietyByCommodityList.status) {
            case Status.LOADING:
              return const Center(
                child: CircularProgressIndicator(
                  color: StyleConstants.mediumGreen,
                ),
              );
            case Status.ERROR:
              return Center(
                child: Text(value.allVarietyByCommodityList.message.toString()),
              );
            case Status.COMPLETED:
              if (value.allVarietyByCommodityList.data!.data!.isEmpty) {
                return const Text("No variety yet!");
              }
              return Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                      ),
                      child: Row(
                        children: [
                          Text(value.allVarietyByCommodityList.data!
                              .data![index].name!),
                          const Spacer(),
                          InkWell(
                            onTap: (){
                              value.deleteVariety(context, value.allVarietyByCommodityList.data!.data![index].id);
                              commodityViewModel.getCommodityVariety(widget.id);
                            },
                            child: const Icon(Icons.delete_outline),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 5),
                  itemCount: value.allVarietyByCommodityList.data!.data!.length,
                  shrinkWrap: true,
                ),
              );
            default:
              return const Text('Something went wrong');
          }
        },
      ),
    );
  }
}
