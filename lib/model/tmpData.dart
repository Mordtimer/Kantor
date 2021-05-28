class TmpCurrency {
  String name;
  String shortName;
  double value;
  double change;
  double changePercent;
  double yearMax;
  double yearMin;

  TmpCurrency(this.name, this.shortName, this.value, this.change,
      this.changePercent, this.yearMax, this.yearMin);
}

class TmpDataList {
  static List<TmpCurrency> list = [
    TmpCurrency('Poland zloty', 'PLN', 2.66, -0.0001, -0.0167, 3.41, 2.49),
    TmpCurrency('Euro', 'EUR', 1.79, 0.0005, 0.0092, 2.22, 1.28),
    TmpCurrency('USA Dolar', 'USD', 3.88, -0.0004, -0.0290, 4.73, 3.38),
    TmpCurrency('Australia Dollar', 'AUD', 4.66, 0.0002, 0.0123, 5.24, 4.28),
    TmpCurrency('Japan Yen', 'JPY', 5.14, -0.0003, -0.0099, 6.25, 5.07),
    TmpCurrency('Switzerland Franc', 'CHF', 6.42, 0.0006, 0.0102, 7.26, 5.56),
    TmpCurrency('Bosnia Mark', 'BAM', 3.51, -0.0006, -0.0245, 4.27, 3.25),
    TmpCurrency('Bulgaria Lev', 'BGN', 3.24, 0.0007, 0.0054, 3.48, 2.24),
    TmpCurrency('Canada Dollar', 'CAD', 5.13, -0.0004, -0.0012, 5.39, 3.23),
    TmpCurrency('Cuba Peso', 'CUP', 2.25, 0.0002, 0.0023, 3.28, 1.93),
    TmpCurrency('Fiji Dollar', 'FJD', 3.21, -0.0004, -0.0098, 4.27, 3.02),
    TmpCurrency('Iceland Krona', 'ISK', 3.57, 0.0001, 0.0112, 4.26, 3.21),
    TmpCurrency('Israel New Shekel', 'ILS', 1.22, -0.0001, -0.0121, 2.25, 1.02),
    TmpCurrency('Russia Rouble', 'RUB', 6.23, 0.0004, 0.0024, 6.54, 4.20),
    TmpCurrency('Singapore Dollar', 'SGD', 3.87, -0.0006, -0.0434, 4.23, 2.23),
    TmpCurrency('South Korea Won', 'KRW', 2.61, 0.0002, 0.0124, 3.22, 1.24),
  ];
}

class TmpDataListShorts {
  static List<String> shorts = [
    'PLN',
    'EUR',
    'USD',
    'AUD',
    'JPY',
    'CHF',
    'BAM',
    'BGN',
    'CAD',
    'CUP',
    'FJD',
    'ISK',
    'ILS',
    'RUB',
    'SGD',
    'KRW'
  ];
}
