// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:kantor_app/model/Currency.dart';
import 'package:kantor_app/model/api.dart';
import 'package:kantor_app/viewModel/ViewModel.dart';

import 'CurrencyConverter.dart';
import 'RatesHisotry.dart';

class CurrencyInfo extends StatelessWidget {
  CurrencyInfo(this.currency);
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: API.fetchInfo(currency.shortName.toLowerCase()),
        builder: (BuildContext context, AsyncSnapshot<List<double>> snapshot) {
          if (snapshot.hasData)
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
                                    style:
                                        Theme.of(context).textTheme.headline5),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Current Exchange",
                                            style: TextStyle(fontSize: 18)),
                                        Text(snapshot.data[1].toString(),
                                            style: TextStyle(fontSize: 18))
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Change",
                                            style: TextStyle(fontSize: 18)),
                                        Text(
                                            snapshot.data[0]
                                                .toStringAsPrecision(3),
                                            style: TextStyle(fontSize: 18)),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Change ‰",
                                            style: TextStyle(fontSize: 18)),
                                        Text(
                                            ((snapshot.data[0] /
                                                        snapshot.data[1]) *
                                                    1000)
                                                .toStringAsPrecision(3),
                                            style: TextStyle(fontSize: 18))
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Year High",
                                            style: TextStyle(fontSize: 18)),
                                        // Text(currency.yearMax.toString(),
                                        //     style: TextStyle(fontSize: 18))
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Year Low",
                                            style: TextStyle(fontSize: 18)),
                                        // Text(currency.yearMin.toString(),
                                        //     style: TextStyle(fontSize: 18))
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
                                    style:
                                        Theme.of(context).textTheme.headline5),
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
                  )),
                ]);
          else if (snapshot.hasError)
            return Icon(
              Icons.error_outline,
              color: Theme.of(context).errorColor,
              size: 60,
            );
          else
            return SizedBox(
              child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor)),
              width: 60,
              height: 60,
            );
        });
  }
}
