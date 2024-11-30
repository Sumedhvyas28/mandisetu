import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/model/purchase_request.dart';
import 'package:mandisetu/viewmodel/admin_product_requests.dart';
import 'package:mandisetu/widget/oops_error_widget.dart';
import 'package:mandisetu/widget/request_card.dart';
import 'package:provider/provider.dart';


class CancelRequestTab extends StatefulWidget {
  const CancelRequestTab({super.key});

  @override
  State<CancelRequestTab> createState() => _CancelRequestTabState();
}

class _CancelRequestTabState extends State<CancelRequestTab> {


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
              if(value.allPurchaseRequestList.data!.data!.cancelled!.isEmpty) {
                return const Center(
                  child: Text('No cancel request yet!'),
                );
              }
              return ListView.builder(
                itemCount: value.allPurchaseRequestList.data!.data!.cancelled!.length,
                itemBuilder: (context, index) {
                  final item = value.allPurchaseRequestList.data!.data!.cancelled![index];
                  return CustomCard(
                    item: item,
                  );
                },
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
              print("Cancel request accepted");
              return;
            },
            backgroundColor: StyleConstants.mediumGreen,
            foregroundColor: Colors.white,
            icon: Icons.done,
            label: 'Accept',
          ),
          SlidableAction(
            onPressed: (context) {
              print("Cancel request rejected");
              return;
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.highlight_remove_rounded,
            label: 'Reject',
          ),
        ],
      ),

      child: RequestCard(item: item,),
    );
  }
}

