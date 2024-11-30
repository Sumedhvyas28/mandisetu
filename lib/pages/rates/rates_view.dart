import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/viewmodel/commodity_viewmodel.dart';
import 'package:mandisetu/viewmodel/mandi_rates_viewmodel.dart';
import 'package:mandisetu/widget/commodities_bottom_sheet.dart';
import 'package:mandisetu/widget/commodity_selet_field.dart';
import 'package:mandisetu/widget/custom_text_form.dart';
import 'package:mandisetu/widget/main_header.dart';
import 'package:mandisetu/widget/oops_error_widget.dart';
import 'package:mandisetu/widget/states_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../model/filter_rate.dart';

// rates 3 bottom nav bar item

class RatesView extends StatefulWidget {
  const RatesView({super.key});

  @override
  State<RatesView> createState() => _RatesViewState();
}

class _RatesViewState extends State<RatesView> {
  MandiRatesViewModel mandiRatesViewModel = MandiRatesViewModel();

  final TextEditingController _commodity =
      TextEditingController(text: "Banana");
  final TextEditingController _state = TextEditingController(text: "Kerala");

  @override
  void initState() {
    super.initState();
    mandiRatesViewModel.getFilteredMandiRates(_commodity.text, _state.text);
  }

  // final TextEditingController _market = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final commodityProvider = Provider.of<CommodityViewModel>(context);

    return Column(
      children: [
        MainHeader(),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => CommoditiesBottomSheet(
                      callBackFunction: (selectedCommodity) async {
                        setState(() {
                          _commodity.text = selectedCommodity.name!;
                        });
                        await mandiRatesViewModel.getFilteredMandiRates(
                          _commodity.text,
                          _state.text,
                        );
                      },
                    ),
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
                          _commodity.text,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => StatesBottomSheet(
                      callBackFunction: (String selectedCommodity) async {
                        setState(() {
                          _state.text = selectedCommodity;
                        });
                        await mandiRatesViewModel.getFilteredMandiRates(
                          _commodity.text,
                          _state.text,
                        );
                      },
                    ),
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
                          _state.text,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ChangeNotifierProvider<MandiRatesViewModel>(
          create: (BuildContext context) => mandiRatesViewModel,
          child: Consumer<MandiRatesViewModel>(
            builder: (context, value, _) {
              switch (value.allFilteredMandiRates.status) {
                case Status.LOADING:
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SpinKitFadingCube(
                          size: 40,
                          color: StyleConstants.mediumGreen,
                        ),
                      ],
                    ),
                  );
                case Status.ERROR:
                  return const OopsErrorWidget();
                case Status.COMPLETED:
                  if (value.allFilteredMandiRates.data!.data!.isEmpty) {
                    return SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/no_data.png", height: 120),
                        ],
                      ),
                    );
                  }

                  return Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const SizedBox(height: 15),
                            // CustomTextFormField(controller: _market, label: "Market"),
                            Text(
                              '${_commodity.text} price today',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 15),
                            ListView.separated(
                              itemCount: value
                                  .allFilteredMandiRates.data!.data!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => ratesCard(value
                                  .allFilteredMandiRates.data!.data![index]),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 15),
                              padding: EdgeInsets.zero,
                            ),
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ),
                  );

                case null:
                  return Text('Null');
              }
            },
          ),
        ),
      ],
    );
  }

  Widget ratesCard(Data data) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.greenAccent.shade100.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.green.shade100.withOpacity(0.5),
              radius: 18,
              child: const Icon(
                Icons.location_on_rounded,
                size: 25,
                color: StyleConstants.darkGreen,
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.state!,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  data.district!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  data.commodity!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 5),
                Text(
                  '₹${data.modalX0020Price}/Qtl',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 5),
                Text(
                  'Min ₹${data.minX0020Price} - Max ₹${data.maxX0020Price}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
