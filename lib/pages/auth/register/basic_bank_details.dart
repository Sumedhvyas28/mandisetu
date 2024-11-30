import 'package:flutter/material.dart';
import 'package:mandisetu/viewmodel/auth_viewmodel.dart';
import 'package:mandisetu/widget/custom_elevated_button.dart';
import 'package:mandisetu/widget/custom_text_form_field_icon.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

class BasicBankDetail extends StatefulWidget {
  BasicBankDetail({super.key, required this.onClick});

  final Function onClick;

  @override
  State<BasicBankDetail> createState() => _BasicBankDetailState();
}

class _BasicBankDetailState extends State<BasicBankDetail> {
  TextEditingController _phoneController = TextEditingController();

  String? filePath;

  String? fileName;

  void _pickPdf() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      final authProvider = Provider.of<AuthViewModel>(context, listen: false);

      if (result != null) {
        // Handle picked file here, you might want to save the file path or perform other actions
        setState(() {
          filePath = result.files.single.path;
          fileName = result.files.single.name;
          authProvider.statementFile = result.files.single.path!;
        });
        // Optionally, you can display the file name or do other operations with the picked file
        print('Picked file path: $filePath');
      } else {
        // User canceled the picker
      }
    } catch (e) {
      print('Error picking PDF: $e');
      // Handle exception/error
    }
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
                    Text('Basic Bank Details',
                        style: Theme.of(context).textTheme.headlineSmall),
                    const Spacer(),
                    Text(
                      '3 / 3',
                      style: Theme.of(context).textTheme.labelLarge,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextFormFieldWithIcon(
                  controller: authProvider.accountNoController,
                  prefixIcon: Icons.person,
                  label: 'Enter your Account Number',
                ),
                const SizedBox(height: 15),
                CustomTextFormFieldWithIcon(
                  controller: authProvider.ifscCodeController,
                  prefixIcon: Icons.phone_rounded,
                  label: 'Enter your IFSC code',
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: _pickPdf,
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
                        Icon(
                          filePath == null
                              ? Icons.upload_file_rounded
                              : Icons.refresh,
                          color: Colors.green,
                          size: filePath == null ? 80 : 50,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          filePath == null
                              ? 'Upload 6 months of Bank Statement'
                              : fileName.toString(),
                          style: filePath == null
                              ? Theme.of(context).textTheme.labelLarge
                              : Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
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
