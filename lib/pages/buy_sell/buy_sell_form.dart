import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/viewmodel/commodity_viewmodel.dart';
import 'package:mandisetu/widget/commodity_selet_field.dart';
import 'package:mandisetu/widget/custom_elevated_button.dart';
import 'package:mandisetu/widget/custom_text_form.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandisetu/widget/variety_bottom_sheet.dart';
import 'package:provider/provider.dart';

class BuyAndSellForm extends StatefulWidget {
  BuyAndSellForm({super.key});

  @override
  State<BuyAndSellForm> createState() => _BuyAndSellFormState();
}

class _BuyAndSellFormState extends State<BuyAndSellForm> {
  TextEditingController _controller = TextEditingController();
  List<XFile>? _images;
  String? _selectedUnit;

  void _pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    setState(() {
      _images = selectedImages;
    });
  }

  void _selectUnit(String unit) {
    setState(() {
      _selectedUnit = unit;
      Provider.of<CommodityViewModel>(context, listen: false)
          .setSelectedUnit(unit);
    });
  }

  Widget _buildUnit(String unit) {
    return GestureDetector(
      onTap: () => _selectUnit(unit),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(),
          color: _selectedUnit == unit ? Colors.green : Colors.transparent,
        ),
        child: Text(
          unit,
          style: TextStyle(
              color: _selectedUnit == unit ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final commodityProvider = Provider.of<CommodityViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              const CommoditySelectField(),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const VarietyBottomSheet(),
                  );
                },
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.greenAccent.shade100.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          commodityProvider.selectedCommodity == ""
                              ? 'Variety/Type'
                              : commodityProvider.selectedCommodity,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: commodityProvider.quantityController,
                label: "Quantity",
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Text(
                    'Total in : ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 10),
                  _buildUnit('Kg'),
                  const SizedBox(width: 10),
                  _buildUnit('Quintal'),
                  const SizedBox(width: 10),
                  _buildUnit('Ton'),
                ],
              ),
              const SizedBox(height: 25),
              CustomTextFormField(
                controller: commodityProvider.rateController,
                label: "Price",
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: commodityProvider.stateController,
                label: "State",
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: commodityProvider.districtController,
                label: "District",
              ),
              const SizedBox(height: 15),
              Text('Commodity Images',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              InkWell(
                onTap: _pickImages,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.shade100.withOpacity(0.2),
                    border: Border.all(color: Colors.green, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_circle,
                          size: 30, color: Colors.green),
                      const SizedBox(height: 15),
                      Text(
                        'Upload Images from device',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  ),
                ),
              ),
              if (_images != null)
                Column(
                  children: [
                    const SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: _images!.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: StyleConstants.darkGreen),
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
                                    Icons.delete_forever,
                                    color: Colors.white,
                                    size: 16,
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
              const SizedBox(height: 25),
              commodityProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: StyleConstants.darkGreen,
                      ),
                    )
                  : CustomElevatedButton(
                      onClick: () {
                        List<String> imagePaths =
                            _images?.map((img) => img.path).toList() ?? [];

                        if (imagePaths.isNotEmpty) {
                          commodityProvider.saveCommodity(imagePaths);
                        } else {
                          print("No image added");
                        }
                      },
                      text: 'Continue',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
