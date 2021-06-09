import 'package:flutter/material.dart';
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
