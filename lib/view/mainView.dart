import 'package:flutter/material.dart';
import 'package:kantor_app/model/Currency.dart';
import 'package:kantor_app/model/cookieManager.dart';
import 'package:kantor_app/viewModel/ViewModel.dart';

import 'CurrencyInfo.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Currency> _list = ViewModel.instance.getCurrencyList();

  void setCurrentCurrency(currency) {
    setState(() {
      ViewModel.instance.currentCurrency = currency;
    });
  }

  void setFavCurrency(index) {
    setState(() {
      if (_list[index].fav) {
        _list[index].fav = false;
        CookieManager.removeFromCookie(_list[index].shortName);
      } else {
        _list[index].fav = true;
        CookieManager.addToCookie(_list[index].shortName);
      }
      _list = ViewModel.instance.getCurrencyList();
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.maybeOf(context).showSnackBar(SnackBar(
        padding: EdgeInsets.all(20),
        content: Text(
            'Ta strona używa cookies w celu: świadczenia usług. Korzystanie z witryny oznacza, że będą one umieszczane w Twoim urządzeniu końcowym.'),
        //backgroundColor: Color(0xFFE0E0E0),
        action: SnackBarAction(
          textColor: Theme.of(super.context).primaryColor,
          label: 'x',
          onPressed: () {},
        ),
        duration: Duration(days: 365),
      ));
    });

    var screenSize = MediaQuery.of(context).size;
    if (screenSize.width > 900) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Kantor', style: Theme.of(context).textTheme.headline3),
          centerTitle: true,
          toolbarHeight: 80,
        ),
        body: Container(
            child: Padding(
          padding: EdgeInsets.fromLTRB(
              screenSize.width / 20, 0, screenSize.width / 15, 0),
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
                                    trailing: IconButton(
                                        icon: Icon(_list[index].fav
                                            ? Icons.star
                                            : Icons.star_border),
                                        onPressed: () {
                                          setFavCurrency(index);
                                        }),
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
                    child: CurrencyInfo(ViewModel.instance.currentCurrency),
                  ))
            ],
          ),
        )),
      );
    } else {
      return Scaffold(
        drawer: Drawer(
          child: ListView.separated(
              // ---------------------------------------------------------------------------------------- List of Currencies
              itemCount: _list.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                    // ---------------------------------------------------------------------------------------- List Item
                    trailing: IconButton(
                        icon: Icon(
                            _list[index].fav ? Icons.star : Icons.star_border),
                        onPressed: () {
                          setFavCurrency(index);
                        }),
                    title: Text(_list[index].shortName,
                        style: Theme.of(context).textTheme.headline5),
                    subtitle: Text(_list[index].name),
                    onTap: () {
                      setCurrentCurrency(_list[index]);
                    });
              }),
        ),
        appBar: AppBar(
          title: Text('Kantor', style: Theme.of(context).textTheme.headline3),
          centerTitle: true,
          toolbarHeight: 80,
        ),
        body: Container(
            child: Padding(
          padding: EdgeInsets.fromLTRB(
              screenSize.width / 20, 0, screenSize.width / 15, 0),
          child: Row(
            children: [ 
              Expanded(
                  // ---------------------------------------------------------------------------------------- Currency Info - Info, Converter, Graph, Details
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                    child: CurrencyInfo(ViewModel.instance.currentCurrency),
                  ))
            ],
          ),
        )),
      );
    }
  }
}
