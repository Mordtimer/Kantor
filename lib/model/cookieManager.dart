// ignore: avoid_web_libraries_in_flutter
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

  static List<String> getCookie() {
    String cookies = document.cookie;
    return cookies.isNotEmpty ? cookies.split("=")[1].split(",") : [];
  }
}
