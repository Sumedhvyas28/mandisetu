import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandisetu/utils/Utils.dart';
import 'package:mandisetu/viewmodel/admin_product_requests.dart';
import 'package:mandisetu/widget/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class NewBannerTab extends StatefulWidget {
  const NewBannerTab({super.key});

  @override
  State<NewBannerTab> createState() => _NewBannerTabState();
}

class _NewBannerTabState extends State<NewBannerTab> {
  List<XFile>? _images;

  void _pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile> selectedImages = await _picker.pickMultiImage();
    setState(() {
      _images = selectedImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminProductRequest>(context);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: _pickImages,
                    child: Container(
                      height: 112,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.add),
                          const SizedBox(height: 10),
                          Text('Add images',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_images != null)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _images!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(_images![index].path),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _images!.removeAt(index);
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),

        //  ===================================================================

        provider.isLoading
            ? const Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: SpinKitThreeBounce(
                    size: 35,
                    color: Colors.green,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomElevatedButton(
                  onClick: () {
                    List<String> imagePaths =
                        _images?.map((img) => img.path).toList() ?? [];
                    if (imagePaths.isNotEmpty) {
                      provider.uploadPromotion(ctx: context, images: imagePaths);
                    }
                    else{
                      Utils.errorSnackBar("Please select image first", context);
                    }
                  },
                  text: 'UPLOAD',
                ),
              ),
      ],
    );
  }
}
