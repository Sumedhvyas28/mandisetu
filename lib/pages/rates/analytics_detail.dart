import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mandisetu/constants/style/style_constants.dart';
import 'package:mandisetu/data/response/status.dart';
import 'package:mandisetu/viewmodel/commodity_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../model/stats.dart';

class AnalyticsDetails extends StatefulWidget {
  const AnalyticsDetails({super.key, required this.commodity});

  final String commodity;

  @override
  State<AnalyticsDetails> createState() => _AnalyticsDetailsState();
}

class _AnalyticsDetailsState extends State<AnalyticsDetails> {
  CommodityViewModel provider = CommodityViewModel();


  @override
  void initState() {
    super.initState();
    Map<String, dynamic> query = {"commodity": widget.commodity};
    provider.getStats(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.commodity),
        backgroundColor: StyleConstants.darkDarkGreen,
      ),
      body: ChangeNotifierProvider<CommodityViewModel>(
        create: (context) => provider,
        child: Consumer<CommodityViewModel>(
          builder: (context, value, _) {
            switch (value.allStatsList.status) {
              case Status.LOADING:
                return const Center(
                  child: CircularProgressIndicator(
                    color: StyleConstants.mediumGreen,
                  ),
                );
              case Status.ERROR:
                return Text(value.allStatsList.message.toString());
              case Status.COMPLETED:
                if (value.allStatsList.data!.data!.isEmpty) {
                  return const Center(
                    child: Text('No data available!'),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 15, right: 10),
                        height: 400,
                        width: double.infinity,
                        child: _LineChart(data: value.allStatsList.data!.data!),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "History",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                            ),
                            Text("Last 7 days's data",
                                style: Theme.of(context).textTheme.labelMedium),
                            const SizedBox(height: 20),
                            ListView.builder(
                              itemCount: value.allStatsList.data!.data!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item =
                                    value.allStatsList.data!.data![index];

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Rate on ${item.date}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                          const Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "₹${item.modal}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                              ),
                                              Text(
                                                '(min ₹${item.min} - max ₹${item.max})',
                                                style: const TextStyle(
                                                    fontSize: 10),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      const Divider(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );

              case null:
                return const Text('Null');
            }
          },
        ),
      ),
    );
  }
}

class _LineChart extends StatelessWidget {
  final List<Data> data;

  const _LineChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      generateLineChartData(data),
    );
  }

  LineChartData generateLineChartData(List<Data> data) {
    final minY =
        data.map((e) => e.min).reduce((a, b) => a < b ? a : b).toDouble();
    final maxY =
        data.map((e) => e.max).reduce((a, b) => a > b ? a : b).toDouble();

    return LineChartData(
      titlesData: titlesData(data, minY, maxY),
      lineBarsData: lineBarsData(data),
      minX: 0,
      maxX: (data.length - 1).toDouble(),
      minY: minY,
      maxY: maxY,
    );
  }

  FlTitlesData titlesData(List<Data> data, double minY, double maxY) {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: bottomTitles(data),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: AxisTitles(
        sideTitles: leftTitles(minY, maxY),
      ),
    );
  }

  Widget leftTitlesWidget(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w200,
      color: Colors.black,
    );

    return Text(value.toInt().toString(),
        style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles(double minY, double maxY) {
    final range = maxY - minY;
    const divisions = 7;
    final interval = range / divisions;

    return SideTitles(
      getTitlesWidget: (value, meta) => leftTitlesWidget(value, meta),
      showTitles: true,
      interval: interval,
      reservedSize: 40,
    );
  }

  SideTitles bottomTitles(List<Data> data) {
    return SideTitles(
      showTitles: true,
      reservedSize: 32,
      interval: 1,
      getTitlesWidget: (value, meta) {
        const style = TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w200,
          color: Colors.black,
        );

        Widget text;
        if (value.toInt() < data.length) {
          final date = data[value.toInt()].date ?? '';
          final formattedDate = formatDate(date);
          text = Text(formattedDate, style: style);
        } else {
          text = const Text('');
        }

        return SideTitleWidget(
          axisSide: meta.axisSide,
          space: 10,
          child: text,
        );
      },
    );
  }

  String formatDate(String date) {
    try {
      final parsedDate = DateFormat('yyyy-MM-dd').parse(date);
      return DateFormat('dd/MMM').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  List<LineChartBarData> lineBarsData(List<Data> data) {
    return [
      LineChartBarData(
        isCurved: true,
        color: Colors.green,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        curveSmoothness: 0.01,
        spots: data.asMap().entries.map((e) {
          return FlSpot(e.key.toDouble(), e.value.modal.toDouble());
        }).toList(),
      ),
      LineChartBarData(
        isCurved: true,
        color: Colors.orangeAccent,
        barWidth: 3,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        curveSmoothness: 0.01,
        spots: data.asMap().entries.map((e) {
          return FlSpot(e.key.toDouble(), e.value.min.toDouble());
        }).toList(),
      ),
      LineChartBarData(
        isCurved: true,
        color: Colors.blue,
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        curveSmoothness: 0.01,
        spots: data.asMap().entries.map((e) {
          return FlSpot(e.key.toDouble(), e.value.max.toDouble());
        }).toList(),
      ),
    ];
  }
}
