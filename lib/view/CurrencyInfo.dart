import 'package:flutter/material.dart';
import 'package:kantor_app/model/tmpData.dart';

import 'CurrencyConverter.dart';
import 'RatesHisotry.dart';

class CurrencyInfo extends StatelessWidget {
  CurrencyInfo(this.currency);
  final TmpCurrency currency;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 0, 12),
            child: Text(currency.shortName + ' - ' + currency.name,
                style: Theme.of(context).textTheme.headline4)),
        Row(
          // ---------------------------------------------------------------------------------------- Currency Info & Converter
          children: [
            Expanded(
              flex: 4,
              child: Card(
                // ---------------------------------------------------------------------------------------- Currency Info Card
                clipBehavior: Clip.antiAlias, elevation: 8,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                      child: Text("Currency Info",
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Current Exchange",
                                  style: TextStyle(fontSize: 18)),
                              Text(currency.value.toString(),
                                  style: TextStyle(fontSize: 18))
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Change", style: TextStyle(fontSize: 18)),
                              Text(currency.change.toString(),
                                  style: TextStyle(fontSize: 18))
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Change %", style: TextStyle(fontSize: 18)),
                              Text(currency.changePercent.toString(),
                                  style: TextStyle(fontSize: 18))
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Year High", style: TextStyle(fontSize: 18)),
                              Text(currency.yearMax.toString(),
                                  style: TextStyle(fontSize: 18))
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Year Low", style: TextStyle(fontSize: 18)),
                              Text(currency.yearMin.toString(),
                                  style: TextStyle(fontSize: 18))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              // ---------------------------------------------------------------------------------------- Converter Card
              flex: 6,
              child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 8,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                      child: Text("Currency Converter",
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    CurrencyConverter(), // ---------------------------------------------------------------------------------------- Converter
                  ],
                ),
              ),
            )
          ],
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 64),
          child:
              RatesHistory(), // ---------------------------------------------------------------------------------------- Exchange Rate History Plot & Details
        ))
      ],
    );
  }
}
