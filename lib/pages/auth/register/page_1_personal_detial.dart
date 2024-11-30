import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mandisetu/viewmodel/auth_viewmodel.dart';
import 'package:mandisetu/widget/custom_elevated_button.dart';
import 'package:mandisetu/widget/custom_text_form_field_icon.dart';
import 'package:provider/provider.dart';

class Page1PersonalDetail extends StatefulWidget {
  Page1PersonalDetail({super.key, required this.onClick});

  final Function onClick;

  @override
  State<Page1PersonalDetail> createState() => _Page1PersonalDetailState();
}

class _Page1PersonalDetailState extends State<Page1PersonalDetail> {
  TextEditingController _phoneController = TextEditingController();

  String? _gstDoc;
  XFile? _images;
  String? imagePath;

  void _pickImages(int i) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? selectedImages = await _picker.pickImage(source: ImageSource.gallery);

    final authProvider = Provider.of<AuthViewModel>(context, listen: false);

    setState(() {
      _images = selectedImages;
      imagePath = _images!.path;
      authProvider.verificationDocumentImage = imagePath!;
    });
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
                    Text('Register',
                        style: Theme.of(context).textTheme.headlineSmall),
                    const Spacer(),
                    Text(
                      '1 / 3',
                      style: Theme.of(context).textTheme.labelLarge,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextFormFieldWithIcon(
                  controller: authProvider.nameController,
                  prefixIcon: Icons.person,
                  label: 'Enter your Name',
                ),
                const SizedBox(height: 20),
                CustomTextFormFieldWithIcon(
                  controller: authProvider.phoneController,
                  prefixIcon: Icons.phone_rounded,
                  label: 'Enter your Phone',
                ),
                const SizedBox(height: 20),
                CustomTextFormFieldWithIcon(
                  controller: authProvider.emailController,
                  prefixIcon: Icons.email,
                  label: 'Enter your Email',
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text('Register as: '),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.greenAccent.shade100.withOpacity(0.2),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  authProvider.setRegisterAs("Wholesaler");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color:
                                        authProvider.registerAs == "Wholesaler"
                                            ? Colors.green
                                            : Colors.transparent,
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Wholesaler',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: authProvider.registerAs ==
                                                    "Wholesaler"
                                                ? Colors.white
                                                : Colors.black),
                                  )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  authProvider.setRegisterAs("Trader");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color:
                                        authProvider.registerAs == "Wholesaler"
                                            ? Colors.transparent
                                            : Colors.green,
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Trader',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: authProvider.registerAs ==
                                                    "Wholesaler"
                                                ? Colors.black
                                                : Colors.white),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.file_copy_sharp),
                    labelText: 'Select verification document',
                    fillColor: Colors.greenAccent.shade100.withOpacity(0.2),
                    filled: true,
                    labelStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  value: _gstDoc,
                  items: <String>[
                    'Mandi Licence',
                    'GST registration',
                    'Gumasta',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _gstDoc = newValue;
                      print(_gstDoc);
                    });
                  },
                ),
                const SizedBox(height: 20),
                if (_gstDoc != null)
                  Column(
                    children: [
                      CustomTextFormFieldWithIcon(
                        controller: _phoneController,
                        prefixIcon: Icons.numbers,
                        label: 'Enter $_gstDoc number',
                      ),
                      const SizedBox(height: 20),
                      if (_images == null)
                        GestureDetector(
                          onTap: () {
                            _pickImages(1);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color:
                                  Colors.greenAccent.shade100.withOpacity(0.2),
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                const Icon(Icons.upload,
                                    color: Colors.green, size: 40),
                                const SizedBox(height: 10),
                                Text(
                                  'Upload ${_gstDoc == null ? 'Selected Document' : _gstDoc}',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      if (_images != null)
                        GestureDetector(
                          onTap: () {
                            _pickImages(1);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: FileImage(
                                    File(_images!.path),
                                  ),
                                  fit: BoxFit.cover),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.refresh,
                                        color: Colors.white, size: 40),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Upload another photo',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
        CustomElevatedButton(
          onClick: widget.onClick,
          text: 'Next',
        ),
      ],
    );
  }
}
