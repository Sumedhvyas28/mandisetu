import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/viewmodel/commodity_viewmodel.dart';
import 'package:mandisetu/widget/add_variety_bottom_sheet.dart';
import 'package:mandisetu/widget/commodity_varity_item.dart';
import 'package:mandisetu/widget/delete_commodity_dialog.dart';
import 'package:mandisetu/widget/oops_error_widget.dart';
import 'package:provider/provider.dart';

class ManageVariety extends StatefulWidget {
  const ManageVariety({super.key});

  @override
  State<ManageVariety> createState() => _ManageVarietyState();
}

class _ManageVarietyState extends State<ManageVariety> {
  late CommodityViewModel commodityViewModel;

  @override
  void initState() {
    super.initState();
    commodityViewModel = CommodityViewModel();
    commodityViewModel.getCommodities();
  }

  Future<void> _handleRefresh() async {
    await commodityViewModel.getCommodities();
  }

  void showCustomDialog(id, name) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteCommodityDialog(
          id: id,
          name: name,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Variety'),
      ),
      body: ChangeNotifierProvider<CommodityViewModel>(
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
                return const OopsErrorWidget();
              case Status.COMPLETED:
                return RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemCount: value.allCommoditiesList.data!.data!.length,
                      itemBuilder: (context, index) {
                        final item =
                            value.allCommoditiesList.data!.data![index];
                        return CommodityVarietyItem(
                          data: item,
                        );
                      },
                    ),
                  ),
                );
              default:
                return const Text('Something went wrong');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return AddVarietyBottomSheet();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
