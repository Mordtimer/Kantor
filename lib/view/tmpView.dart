import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:kantor_app/model/tmpData.dart';

class TmpView extends StatefulWidget {
  @override
  _TmpViewState createState() => _TmpViewState();
}

class _TmpViewState extends State<TmpView> {
  TmpCurrency _currentCurrency;
  _TmpViewState() {
    _currentCurrency = _list[0];
  }
  void setCurrentCurrency(currency) {
    setState(() {
      _currentCurrency = currency;
    });
  }

  List<TmpCurrency> _list = TmpDataList.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kantor', style: Theme.of(context).textTheme.headline3),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(96, 0, 192, 0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Theme.of(context).cardColor,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: ListView.separated(
                            // ---------------------------------------------------------------------------------------- List of Currencies
                            itemCount: _list.length,
                            separatorBuilder: (context, index) => Divider(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                  // ---------------------------------------------------------------------------------------- List Item
                                  // leading: flag_icon,
                                  title: Text(_list[index].shortName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                  subtitle: Text(_list[index].name),
                                  onTap: () {
                                    setCurrentCurrency(_list[index]);
                                  });
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                // ---------------------------------------------------------------------------------------- Currency Info - Info, Converter, Graph, Details
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                  child: CurrencyInfo(_currentCurrency),
                ))
          ],
        ),
      )),
    );
  }
}

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

class CurrencyConverter extends StatefulWidget {
  //---------------------------------------------------------------------------------------- TODO: Converter Functionality
  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  List<String> _nameList = TmpDataListShorts.shorts;
  String dropdownValueFrom = "USD";
  String dropdownValueTo = "EUR";
  TextEditingController fieldValueFrom = TextEditingController();
  TextEditingController fieldValueTo = TextEditingController(text: "0");

  void swapConvertedCurrencies() {
    setState(() {
      String tmp = dropdownValueFrom;
      dropdownValueFrom = dropdownValueTo;
      dropdownValueTo = tmp;
    });
    getConverterResponse();
  }

  void getConverterResponse() async {
    if (fieldValueFrom.text != null && fieldValueFrom.text != "") {
      var queryParameters = {
        'from': '${dropdownValueFrom.toLowerCase()}',
        'to': '${dropdownValueTo.toLowerCase()}'
      };
      var uri =
          Uri.https('kantor-app.herokuapp.com', '/currencies', queryParameters);

      final response = await http.get(uri, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Access-Control_Allow_Origin": "*"
      });

      if (response.statusCode == 200) {
        String convertionValue = response.body.toString();
        double doubleValue = double.parse(
            convertionValue.substring(9, convertionValue.length - 2));
        double finalResult = double.parse(fieldValueFrom.text) * doubleValue;
        setState(() {
          fieldValueTo.text = finalResult.toStringAsFixed(2);
        });
      } else {
        throw Exception('Failed to get converter response');
      }
    } else {
      setState(() {
        fieldValueTo.text = 0.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Padding(
        padding: const EdgeInsets.all(43.0),
        child: Column(
          // ---------------------------------------------------------------------------------------- Converter - From
          children: [
            DropdownButton<String>(
              value: dropdownValueFrom,
              elevation: 16,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueFrom = newValue;
                });
                getConverterResponse();
              },
              items: _nameList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 32),
                  ),
                );
              }).toList(),
            ),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: TextField(
                controller: fieldValueFrom,
                onChanged: (value) => getConverterResponse(),
                style: TextStyle(fontSize: 24),
                obscureText: false,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  //labelText: 'From',
                ),
                //onChanged: (value) => fieldValueFrom.text,
              ),
            )
          ],
        ),
      )),
      Padding(
        padding: const EdgeInsets.only(top: 48),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).buttonColor,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: IconButton(
            // ---------------------------------------------------------------------------------------- Converter - Swap Button
            icon: Icon(Icons.sync_alt),
            iconSize: 48,
            onPressed: () {
              swapConvertedCurrencies();
            },
          ),
        ),
      ),
      Expanded(
          child: Padding(
        padding: const EdgeInsets.all(33.0),
        child: Column(
          // ---------------------------------------------------------------------------------------- Converter - To
          children: [
            DropdownButton<String>(
              value: dropdownValueTo,
              elevation: 16,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueTo = newValue;
                });
                getConverterResponse();
              },
              items: _nameList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 32),
                  ),
                );
              }).toList(),
            ),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: TextField(
                controller: fieldValueTo,
                style: TextStyle(fontSize: 24),
                obscureText: false,
                readOnly: true,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9,]')),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  //labelText: '',
                ),
                //onChanged: (value) => fieldValueTo.text,
              ),
            )
          ],
        ),
      ))
    ]);
  }
}

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
                child: Container(
                    // ---------------------------------------------------------------------------------------- TODO: Graph
                    color: Colors.white),
              ),
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                          // ---------------------------------------------------------------------------------------- Rates History Details List -
                          itemCount: 50,
                          //separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) {
                            return Container(
                              color: pickColor(index),
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("01.01.2021"),
                                  //Icon(icon) // Rate Indicator - UpArrowGreen/DownArrowRed
                                  Text("1.00")
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
