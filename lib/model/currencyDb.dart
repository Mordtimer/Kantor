class CurrencyDb {
  DateTime date;
  String name;
  double value;

  CurrencyDb(this.date, this.name, this.value);

  @override
  String toString() {
    return date.toString() + " | " + name + " | " + value.toString();
  }
}
