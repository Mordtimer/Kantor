import 'dart:html';

class CookieManager {
  static void addToCookie(String value) {
    // 2592000 sec = 30 days.
    String cookies = document.cookie;
    if (cookies != "") cookies = document.cookie.split("=")[1];
    document.cookie =
        "favCurrency=${cookies + value + ','}; max-age=2592000; path=/;";
  }

  static void removeFromCookie(String value) {
    String cookies = document.cookie;
    if (cookies != "")
      cookies = document.cookie.split("=")[1].replaceFirst(value + ",", "");
    document.cookie = "favCurrency=$cookies; path=/;";
  }

  static String getCookie(String key) {
    String cookies = document.cookie;
    List<String> listValues =
        cookies.isNotEmpty ? cookies.split(";") : List<String>();
    String matchVal = "";
    for (int i = 0; i < listValues.length; i++) {
      List<String> map = listValues[i].split("=");
      String _key = map[0].trim();
      String _val = map[1].trim();
      if (key == _key) {
        matchVal = _val;
        break;
      }
    }
    return matchVal;
  }
}
