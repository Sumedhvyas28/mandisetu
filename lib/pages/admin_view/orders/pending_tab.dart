import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/model/purchase_request.dart';
import 'package:mandisetu/pages/admin_view/orders/order_details.dart';
import 'package:mandisetu/viewmodel/admin_product_requests.dart';
import 'package:mandisetu/widget/oops_error_widget.dart';
import 'package:mandisetu/widget/request_card.dart';
import 'package:provider/provider.dart';

class PendingRequestTab extends StatefulWidget {
  const PendingRequestTab({super.key});

  @override
  State<PendingRequestTab> createState() => _PendingRequestTabState();
}

class _PendingRequestTabState extends State<PendingRequestTab> {
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
              if (value
                  .allPurchaseRequestList.data!.data!.unapproved!.isEmpty) {
                return const Center(
                  child: Text('No order request yet!'),
                );
              }
              return Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async{
                      productRequest.getAllPurchaseRequest();
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      itemCount:
                          value.allPurchaseRequestList.data!.data!.unapproved!.length,
                      itemBuilder: (context, index) {
                        final item = value
                            .allPurchaseRequestList.data!.data!.unapproved![index];
                        return CustomCard(
                          item: item,
                        );
                      },
                    ),
                  ),

                  if(value.isLoading)
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

    final provider = Provider.of<AdminProductRequest>(context);

    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dragDismissible: false,
        dismissible: DismissiblePane(onDismissed: () {}),
        extentRatio: 0.5,
        children: [
          SlidableAction(
            onPressed: (context) {
              print("Accepted: ${item.id}");
              provider.approveRequest(context, item.id);
              return;
            },
            backgroundColor: StyleConstants.mediumGreen,
            foregroundColor: Colors.white,
            icon: Icons.done,
            label: 'Accept',
          ),
          SlidableAction(
            onPressed: (context) {
              print("Rejected ${item.id}");
              provider.cancelRequest(context, item.id);
              return;
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.highlight_remove,
            label: 'Reject',
          ),
        ],
      ),
      child: RequestCard(item: item,),
    );
  }
}
