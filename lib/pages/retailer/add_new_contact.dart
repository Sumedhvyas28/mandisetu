import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/viewmodel/trader_viewmodel.dart';
import 'package:mandisetu/widget/custom_elevated_button.dart';
import 'package:mandisetu/widget/custom_text_form.dart';
import 'package:mandisetu/widget/custom_text_form_field_icon.dart';
import 'package:provider/provider.dart';

class AddNewRetailerContact extends StatefulWidget {
  AddNewRetailerContact({super.key});

  @override
  State<AddNewRetailerContact> createState() => _AddNewRetailerContactState();
}

class _AddNewRetailerContactState extends State<AddNewRetailerContact> {

  TextEditingController nameController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController businessNameController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final traderViewModel = Provider.of<TraderViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Contact'),
        backgroundColor: StyleConstants.darkGreen,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomTextFormField(
                  controller: nameController, label: 'Enter Full Name'),
              const SizedBox(height: 20),
              CustomTextFormField(
                  controller: mobileController, label: 'Enter Mobile Number'),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: businessNameController,
                label: 'Enter Business Name',
              ),
              const SizedBox(height: 20),
              CustomTextFormFieldWithIcon(
                controller: locationController,
                prefixIcon: Icons.location_on_rounded,
                label: 'Location',
              ),
              const SizedBox(height: 40),
              traderViewModel.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: StyleConstants.darkGreen,
                      ),
                    )
                  : CustomElevatedButton(
                      onClick: () {
                        dynamic data = jsonEncode({
                          "name": nameController.text,
                          "phone": mobileController.text,
                          "shop_name": businessNameController.text,
                          "address": locationController.text
                        });
                        traderViewModel.addDukandar(context, data);
                      },
                      text: 'ADD',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
