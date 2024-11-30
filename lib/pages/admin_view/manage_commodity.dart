import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/viewmodel/commodity_viewmodel.dart';
import 'package:mandisetu/widget/add_commodity_bs.dart';
import 'package:mandisetu/widget/delete_commodity_dialog.dart';
import 'package:mandisetu/widget/oops_error_widget.dart';
import 'package:provider/provider.dart';

class ManageCommodity extends StatefulWidget {
  const ManageCommodity({super.key});

  @override
  State<ManageCommodity> createState() => _ManageCommodityState();
}

class _ManageCommodityState extends State<ManageCommodity> {
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
        title: const Text('Manage Commodity'),
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
                  child: GridView.builder(
                    itemCount: value.allCommoditiesList.data!.data!.length,
                    padding: const EdgeInsets.all(15),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 70,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.shade100.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              width: 1, color: StyleConstants.darkGreen),
                        ),
                        child: InkWell(
                          onLongPress: () {
                            showCustomDialog(
                              value.allCommoditiesList.data!.data![index].id,
                              value.allCommoditiesList.data!.data![index].name,
                            );
                          },
                          child: Center(
                            child: Text(
                              value.allCommoditiesList.data!.data![index].name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
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
              return AddCommodityBottomSheet();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
