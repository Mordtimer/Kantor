class CurrencyDb {
  DateTime date;
  String name;
  double value;
  String get dateStr  {
    
  String _month, _day;
    if (date.month < 10) _month = "0${date.month.toString()}";
    else _month = date.month.toString();

    if (date.day < 10) _day = " ${date.day.toString()}";
    else _day = date.day.toString();
    return "${_day} / ${_month}";
    }

  CurrencyDb(this.date, this.name, this.value);
  
  @override
  String toString() {
    return date.toString() + " | " + name + " | " + value.toString();
  }
}
