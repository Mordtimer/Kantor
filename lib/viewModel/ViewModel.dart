import 'package:kantor_app/model/Currency.dart';

class ViewModel {
  static List<Currency> currencyList = [
    Currency('Euro', 'EUR'),
    Currency('USA Dolar', 'USD'),
    Currency('Pound Sterling', 'GBP'),
    Currency('Australia Dollar', 'AUD'),
    Currency('Japan Yen', 'JPY'),
    Currency('Russia Rouble', 'RUB'),
    Currency('Switzerland Franc', 'CHF'),
    Currency('Canada Dollar', 'CAD'),
    Currency('Czech Koruna', 'CZK'),
  ];

  Currency currentCurrency = currencyList[0];
}
