import 'package:flutter/material.dart';
import 'package:kantor_app/model/api.dart';
import 'package:kantor_app/model/currencyDb.dart';
import 'package:kantor_app/viewModel/ViewModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RatesHistory extends StatefulWidget {
  @override
  State<RatesHistory> createState() => _RatesHistoryState();
}

class _RatesHistoryState extends State<RatesHistory> {
  
  Color pickColor(int index) {
    if (index % 2 == 0)
      return Colors.white;
    else
      return Theme.of(context).cardColor;
  }
  
  TrackballBehavior _trackballBehavior;
     @override
    void initState(){
      _trackballBehavior = TrackballBehavior(
                  // Enables the trackball
                  enable: true,
                  activationMode: ActivationMode.singleTap,
                  tooltipSettings: InteractiveTooltip(
                    enable: true,
                    format: 'point.x : point.y', 
                  )
                );
 
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 8,
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 8, 16),
                  child: FutureBuilder(
                      future: API.fetchHistoryRates(
                          ViewModel.instance.currentCurrency.shortName
                              .toLowerCase(),
                          90),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<CurrencyDb>> snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            child: SfCartesianChart(
                              //crosshairBehavior: _crosshairBehavior,
                              trackballBehavior: _trackballBehavior,
                              primaryXAxis: DateTimeAxis( interactiveTooltip: InteractiveTooltip(enable: true)
                              ),
                              series: <ChartSeries>[
                                LineSeries<CurrencyDb, DateTime>(
                                    dataSource: snapshot.data,
                                    xValueMapper: (CurrencyDb currency, _) =>
                                        currency.date,
                                    yValueMapper: (CurrencyDb currency, _) =>
                                        currency.value)
                              ],
                            ),
                          );
                        }
                        return Container();
                      })),
            ),
            VerticalDivider(),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("Exchange Rate History Details",
                          style: Theme.of(context).textTheme.headline5)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date",
                            style: Theme.of(context).textTheme.bodyText1),
                        //Icon(icon) // Rate Indicator - UpArrowGreen/DownArrowRed
                        Text("Exchange Rate",
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  FutureBuilder(
                      future: API.fetchHistoryRates(
                          ViewModel.instance.currentCurrency.shortName
                              .toLowerCase(),
                          30),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<CurrencyDb>> snapshot) {
                        if (snapshot.hasData)
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: ListView.builder(
                                  // ---------------------------------------------------------------------------------------- Rates History Details List -
                                  itemCount: snapshot.data.length,
                                  //separatorBuilder: (context, index) => Divider(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      color: pickColor(index),
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(snapshot.data[index].dateStr),

                                          //Icon(icon) // Rate Indicator - UpArrowGreen/DownArrowRed
                                          Text(snapshot.data[index].value
                                              .toString())
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          );
                        return Container(
                          color: Colors.red,
                        );
                      })
                ],
              ),
            ),
          ],
        ));
  }
}
