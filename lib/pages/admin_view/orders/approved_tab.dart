import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/model/purchase_request.dart';
import 'package:mandisetu/viewmodel/admin_product_requests.dart';
import 'package:mandisetu/widget/oops_error_widget.dart';
import 'package:mandisetu/widget/request_card.dart';
import 'package:provider/provider.dart';

class ApprovedRequestTab extends StatefulWidget {
  const ApprovedRequestTab({super.key});

  @override
  State<ApprovedRequestTab> createState() => _ApprovedRequestTabState();
}

class _ApprovedRequestTabState extends State<ApprovedRequestTab> {
  AdminProductRequest productRequest = AdminProductRequest();

  @override
  void initState() {
    super.initState();
    productRequest.getAllPurchaseRequest();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminProductRequest>(
      create: (context) => productRequest,
      child: Consumer<AdminProductRequest>(
        builder: (context, value, _) {
          switch (value.allPurchaseRequestList.status) {
            case Status.LOADING:
              return const Center(
                child: CircularProgressIndicator(
                  color: StyleConstants.mediumGreen,
                ),
              );
            case Status.ERROR:
              return const OopsErrorWidget();
            case Status.COMPLETED:
              if (value.allPurchaseRequestList.data!.data!.approved!.isEmpty) {
                return const Center(
                  child: Text('No request approved yet!'),
                );
              }
              return Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      productRequest.getAllPurchaseRequest();
                    },
                    child: ListView.builder(
                      itemCount: value
                          .allPurchaseRequestList.data!.data!.approved!.length,
                      itemBuilder: (context, index) {
                        final item = value.allPurchaseRequestList.data!.data!
                            .approved![index];
                        return CustomCard(
                          item: item,
                        );
                      },
                    ),
                  ),
                  if (value.isLoading)
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.black45,
                      child: const Center(
                        child: SpinKitFadingCube(
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              );

            case null:
              return const Text('Null');
          }
        },
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Approved item;

  const CustomCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dragDismissible: false,
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            onPressed: (context) {
              print("Delivered : ${item.id}");
              return;
            },
            backgroundColor: StyleConstants.mediumGreen,
            foregroundColor: Colors.white,
            icon: Icons.done,
            label: 'Delivered',
          ),
        ],
      ),
      child: RequestCard(
        item: item,
      ),
    );
  }
}
