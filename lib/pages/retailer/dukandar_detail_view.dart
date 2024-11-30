import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/widget/commodity_selet_field.dart';
import 'package:mandisetu/widget/sale_bottom_sheet.dart';

import '../../model/dukandar.dart';

class DukandarDetailView extends StatelessWidget {
  final Data data;
  const DukandarDetailView({super.key, required this.data});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dukandar Profile'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            radius: 50,
            child: const Icon(CupertinoIcons.person_solid,
                color: Colors.black, size: 45),
          ),
          const SizedBox(height: 15),
          Text(
            data.name!,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                size: 20,
                color: Colors.grey,
              ),
              const SizedBox(width: 10),
              Text(data.address!),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.call,
                    size: 18,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 4),
                  Text(data.phone!),
                ],
              ),
              const SizedBox(width: 30),
              const Row(
                children: [
                  Icon(
                    Icons.add_business,
                    size: 18,
                    color: Colors.red,
                  ),
                  SizedBox(width: 4),
                  Text('Trader'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            color: Colors.grey.shade200,
            height: 5,
            width: double.infinity,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const DukandarSaleBottomSheet(dukandarId: "1",),
                  );
                },
                child: const Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: StyleConstants.darkGreen,
                      radius: 25,
                      child: Icon(
                        Icons.playlist_add_outlined,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Add Order'),
                  ],
                ),
              ),
              const Column(
                children: [
                  CircleAvatar(
                    backgroundColor: StyleConstants.darkGreen,
                    radius: 25,
                    child: Icon(
                      Icons.playlist_add_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Add Order'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            color: Colors.grey.shade200,
            height: 5,
            width: double.infinity,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}


