import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:kantor_app/model/tmpData.dart';

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
