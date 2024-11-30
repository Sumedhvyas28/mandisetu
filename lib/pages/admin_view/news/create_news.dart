import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/utils/Utils.dart';
import 'package:mandisetu/viewmodel/admin_product_requests.dart';
import 'package:mandisetu/widget/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class CreateNews extends StatefulWidget {
  const CreateNews({super.key});

  @override
  State<CreateNews> createState() => _CreateNewsState();
}

class _CreateNewsState extends State<CreateNews> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  XFile? _images;
  String? imagePath;

  void _pickImages(int i) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? selectedImages =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _images = selectedImages;
      imagePath = _images!.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminProductRequest>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            if (_images == null)
              GestureDetector(
                onTap: () {
                  _pickImages(1);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.shade100.withOpacity(0.2),
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.upload, color: Colors.green, size: 40),
                      const SizedBox(height: 10),
                      Text(
                        'Upload banner image',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              ),
            if (_images != null)
              GestureDetector(
                onTap: () {
                  _pickImages(1);
                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(
                        File(_images!.path),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
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
            const SizedBox(height: 15),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter News heading',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _contentController,
              style: Theme.of(context).textTheme.titleSmall,
              decoration: InputDecoration(
                hintText: 'Enter news content here....',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              maxLines: 10,
            ),
            const SizedBox(height: 20),
            provider.isLoading
                ? const Center(
                    child: SpinKitThreeBounce(
                      size: 35,
                      color: StyleConstants.darkGreen,
                    ),
                  )
                : CustomElevatedButton(
                    onClick: () {
                      if (_titleController.text.isEmpty ||
                          _contentController.text.isEmpty ||
                          _images == null) {
                        Utils.errorSnackBar(
                            "Please fill required filled", context);
                      } else {
                        provider.uploadNews(
                          title: _titleController.text,
                          desc: _contentController.text,
                          image: _images!.path,
                          context: context,
                        );
                      }
                    },
                    text: 'UPLOAD',
                  ),
          ],
        ),
      ),
    );
  }
}
