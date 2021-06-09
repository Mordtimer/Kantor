import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

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
}
