import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mandisetu/viewmodel/auth_viewmodel.dart';
import 'package:mandisetu/widget/custom_elevated_button.dart';
import 'package:mandisetu/widget/custom_text_form_field_icon.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class BusinessDetail extends StatefulWidget {
  const BusinessDetail({super.key, required this.onClick});

  final Function onClick;

  @override
  State<BusinessDetail> createState() => _BusinessDetailState();
}

class _BusinessDetailState extends State<BusinessDetail> {
  final TextEditingController _phoneController = TextEditingController();

  XFile? _aadhaarImage;
  XFile? _panImage;
  XFile? _shopImage;

  Future<void> _pickImage(int type) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    final authProvider = Provider.of<AuthViewModel>(context, listen: false);

    setState(() {
      if (type == 1) {
        _aadhaarImage = selectedImage;
        authProvider.aadhaarCardImage = _aadhaarImage!.path;
      } else if (type == 2) {
        _panImage = selectedImage;
        authProvider.panCardImage = _panImage!.path;
      } else if (type == 3) {
        _shopImage = selectedImage;
        authProvider.shopImageImage = _shopImage!.path;
      }
    });
  }

  Widget _buildImageUploadSection(String title, XFile? image, int type) {
    return GestureDetector(
      onTap: () => _pickImage(type),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.greenAccent.shade100.withOpacity(0.2),
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const Icon(Icons.upload, color: Colors.green, size: 40),
            const SizedBox(height: 10),
            Text(title, style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadedImage(XFile image, int type) {
    return GestureDetector(
      onTap: () => _pickImage(type),
      child: Container(
        width: double.infinity,
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(image: FileImage(File(image.path)), fit: BoxFit.cover),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.refresh, color: Colors.white, size: 40),
                const SizedBox(height: 10),
                Text('Upload another document', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Business Details', style: Theme.of(context).textTheme.headlineSmall),
                    const Spacer(),
                    Text('2 / 3', style: Theme.of(context).textTheme.labelLarge),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextFormFieldWithIcon(controller: authProvider.businessNameController, prefixIcon: Icons.person, label: 'Enter your Business name'),
                const SizedBox(height: 20),
                CustomTextFormFieldWithIcon(controller: authProvider.officeAddressController, prefixIcon: Icons.home_filled, label: 'Enter your office address'),
                const SizedBox(height: 20),
                CustomTextFormFieldWithIcon(controller: authProvider.officePhoneController, prefixIcon: Icons.phone_rounded, label: 'Enter your office phone no.'),
                const SizedBox(height: 20),
                CustomTextFormFieldWithIcon(controller: authProvider.aadharController, prefixIcon: Icons.person, label: 'Enter Aadhaar number'),
                const SizedBox(height: 20),
                CustomTextFormFieldWithIcon(controller: authProvider.panController, prefixIcon: Icons.person, label: 'Enter Pan card number'),
                const SizedBox(height: 15),
                if (_aadhaarImage == null) _buildImageUploadSection('Upload Aadhaar card photo', _aadhaarImage, 1),
                if (_aadhaarImage != null) _buildUploadedImage(_aadhaarImage!, 1),
                const SizedBox(height: 15),
                if (_panImage == null) _buildImageUploadSection('Upload Pan card photo', _panImage, 2),
                if (_panImage != null) _buildUploadedImage(_panImage!, 2),
                const SizedBox(height: 15),
                if (_shopImage == null) _buildImageUploadSection('Upload your shop photo', _shopImage, 3),
                if (_shopImage != null) _buildUploadedImage(_shopImage!, 3),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
        CustomElevatedButton(onClick: widget.onClick, text: 'Next'),
      ],
    );
  }
}
