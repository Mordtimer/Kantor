class Currency {
  String name;
  String shortName;

  Currency(this.name, this.shortName);
}

class CurrencyList {
  static List<Currency> list = [
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
}
