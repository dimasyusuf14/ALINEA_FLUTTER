import 'dart:convert';

import 'package:alinea/utilities/api_constant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../utilities/utilities.dart';

enum APIMethod { post, get, delete, put }

class APIServices {
  static var client = http.Client();

  static Future api({
    var requestBodyMap = const {},
    required String endPoint,
    bool withToken = false,
    String param = "",
    required var type,
  }) async {
    Map<String, String> headers = {};

    headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    if (withToken) {
      final box = GetStorage();
      var token = box.read('token');
      logPrint("Token : $token");
      headers.addAll({"Authorization": "Bearer $token"});

      logPrint("URL PARSE : $kBaseUrl&key=$token");
    }

    logPrint("REQUEST BODY : ${jsonEncode(requestBodyMap)}");

    var response;
    if (type == APIMethod.post) {
      response = await client.post(
        Uri.parse("$kBaseUrl$endPoint$param"),
        headers: headers,
        body: requestBodyMap.toString().isNotEmpty
            ? jsonEncode(requestBodyMap)
            : null,
      );
    } else if (type == APIMethod.get) {
      response = await client.get(
        Uri.parse("$kBaseUrl$endPoint$param"),
        headers: headers,
      );
    } else if (type == APIMethod.put) {
      response = await client.put(
        Uri.parse("$kBaseUrl$endPoint$param"),
        headers: headers,
        body: requestBodyMap.toString().isNotEmpty
            ? jsonEncode(requestBodyMap)
            : null,
      );
    } else if (type == APIMethod.delete) {
      response = await client.delete(
        Uri.parse("$kBaseUrl$endPoint$param"),
        headers: headers,
      );
    }

    logPrint("URL PARSE : ${Uri.parse("$kBaseUrl$endPoint$param")}");

    logPrint("$endPoint RESPONSE BODY : ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      logPrint('ERROR SERVICES ${json.decode(response.body)}');
      return json.decode(response.body);
    }
  }
}
