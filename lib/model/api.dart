import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'currencyDb.dart';

class API {
  static Future<double> fetchRate(String currency) async {
    var queryParameters = {'from': '${currency.toLowerCase()}', 'to': 'pln'};
    var uri =
        Uri.https('kantor-app.herokuapp.com', '/currencies', queryParameters);

    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      "Access-Control_Allow_Origin": "*"
    });
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      return json["value"];
    } else {
      // można jakiś kod zwrócić
      throw Exception('Problem z zapytaniem');
    }
  }

  static Future<List<CurrencyDb>> fetchHistoryRates(
      String currency, int days) async {
    var queryParameters = {
      'currency': '${currency.toLowerCase()}',
      'days': '$days'
    };
    var uri = Uri.https('kantor-app.herokuapp.com', '/series', queryParameters);

    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      "Access-Control_Allow_Origin": "*"
    });
    if (response.statusCode == 200) {
      List<CurrencyDb> list = new List<CurrencyDb>();
      List json = jsonDecode(response.body);
      json.forEach((el) => {
            list.add(CurrencyDb(
              HttpDate.parse(el["date"]),
              currency,
              el["value"],
            ))
          });
      return list;
    } else {
      // można jakiś kod zwrócić
      throw Exception('Problem z zapytaniem');
    }
  }

  static Future<double> fetchChange(String currency) async {
    var queryParameters = {
      'currency': '${currency.toLowerCase()}',
      'days': '2'
    };
    var uri = Uri.https('kantor-app.herokuapp.com', '/series', queryParameters);

    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      "Access-Control_Allow_Origin": "*"
    });

    print(response.body.toString());
    if (response.statusCode == 200) {
      List json = jsonDecode(response.body);
      return json[1]["value"] - json[0]["value"];
    } else {
      // można jakiś kod zwrócić
      throw Exception('Problem z zapytaniem');
    }
  }
}
