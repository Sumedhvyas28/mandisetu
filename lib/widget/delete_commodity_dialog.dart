import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mandisetu/viewmodel/commodity_viewmodel.dart';
import 'package:provider/provider.dart';

class DeleteCommodityDialog extends StatefulWidget {
  const DeleteCommodityDialog(
      {super.key, this.id, required this.name});

  final dynamic id;
  final String name;

  @override
  State<DeleteCommodityDialog> createState() => _DeleteCommodityDialogState();
}

class _DeleteCommodityDialogState extends State<DeleteCommodityDialog> {
  bool isEditing = false;

  final TextEditingController _commodityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _commodityController.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CommodityViewModel>(context);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isEditing ? 'Update' : 'Actions',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            if (isEditing)
              Column(
                children: [
                  TextField(
                    controller: _commodityController,
                    decoration:
                        const InputDecoration(hintText: 'Enter updates name'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() async {
                        if (!isEditing) {
                          isEditing = true;
                        } else {
                          dynamic data =
                              jsonEncode({"name": _commodityController.text});
                          await provider.editCommodity(
                              context, data, widget.id);
                        }
                      });
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                ),
                if (!isEditing) const SizedBox(width: 8),
                if (!isEditing)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await provider.deleteCommodity(context, widget.id);
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
