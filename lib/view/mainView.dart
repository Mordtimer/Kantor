import 'package:flutter/material.dart';
import 'package:kantor_app/model/api.dart';
import 'package:kantor_app/model/tmpData.dart';
import 'package:kantor_app/viewModel/ViewModel.dart';

import 'CurrencyInfo.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  ViewModel viewmodel = ViewModel();

  TmpCurrency _currentCurrency;
  _MainViewState() {
    _currentCurrency = _list[0];
  }
  void setCurrentCurrency(currency) {
    setState(() {
      _currentCurrency = currency;
    });
  }

  List<TmpCurrency> _list = TmpDataList.list;
  Future<double> futureRate;

  @override
  void initState() {
    futureRate = API.fetchRate("eur");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
        future: futureRate,
        builder: (context, snapshot) {
          print(snapshot.hasData);
          if (snapshot.hasData) {
            return Text(snapshot.data.toString());
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Text("xd");
        });
  }
}
