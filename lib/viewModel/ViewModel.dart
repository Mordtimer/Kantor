import 'package:kantor_app/model/CookieManager.dart';
import 'package:kantor_app/model/Currency.dart';
import 'package:kantor_app/model/api.dart';
import 'package:kantor_app/model/currencyDb.dart';

class ViewModel {
  ViewModel._privateConstructor();

  static final ViewModel _instance = ViewModel._privateConstructor();

  static ViewModel get instance => _instance;

  static List<Currency> _currencyList = [
    Currency('Euro', 'EUR'),
    Currency('USA Dolar', 'USD'),
    Currency('Pound Sterling', 'GBP'),
    Currency('Australia Dollar', 'AUD'),
    Currency('Japan Yen', 'JPY'),
    //Currency('Russia Rouble', 'RUB'),
    Currency('Switzerland Franc', 'CHF'),
    Currency('Canada Dollar', 'CAD'),
    Currency('Czech Koruna', 'CZK'),
  ];

  Future<List<CurrencyDb>> getHistoryList(String currency, int days) {
    return API.fetchHistoryRates(currency, days);
  }

  Currency _currentCurrency = _currencyList[0];
  Currency get currentCurrency => _currentCurrency;
  set currentCurrency(value) => _currentCurrency = value;

  List<Currency> getCurrencyList() {
    final favList = CookieManager.getCookie();
    _currencyList.forEach((element) {
      if (favList.contains(element.shortName)) element.fav = true;
    });
    _currencyList.sort((a, b) => a.shortName.compareTo(b.shortName));
    _currencyList.sort((a, b) => b.fav.toString().compareTo(a.fav.toString()));
    return _currencyList;
  }

  Future<List<double>> getCurrencyInfo() async {
    API.fetchChange(_currentCurrency.shortName.toLowerCase());
  }
}
