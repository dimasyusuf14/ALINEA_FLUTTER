import 'dart:convert';
import 'dart:io';

import 'package:alinea/services/utilities/api_constant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'utilities/utilities.dart';

enum APIMethod { post, get, delete, put, multipart }

class APIServices {
  static var client = http.Client();

  static Future api({
    var requestBodyMap = const {},
    File? file,
    required String endPoint,
    bool withToken = true,
    String param = "",
    required var type,
  }) async {
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    if (withToken) {
      final box = GetStorage();
      var token = box.read("token");
      logPrint("Token : $token");
      headers.addAll({"Authorization": "Bearer $token"});

      logPrint("URL PARSE : $kBaseUrl&key=$token");
    }

    logPrint("REQUEST BODY : ${jsonEncode(requestBodyMap)}");

    var response;

    if (type == APIMethod.post) {
      response = await client.post(
        Uri.parse("$kBaseUrl$endPoint$param"),
        headers: headers..addAll({"Content-Type": "application/json"}),
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
        headers: headers..addAll({"Content-Type": "application/json"}),
        body: requestBodyMap.toString().isNotEmpty
            ? jsonEncode(requestBodyMap)
            : null,
      );
    } else if (type == APIMethod.delete) {
      response = await client.delete(
        Uri.parse("$kBaseUrl$endPoint$param"),
        headers: headers,
      );
    } else if (type == APIMethod.multipart) {
      logPrint('Ini dari multipart method');

      var request = http.MultipartRequest('POST', Uri.parse("$kBaseUrl$endPoint$param"));
      request.headers.addAll(headers);

      requestBodyMap.forEach((key, value) async {
        if (value is File) {
          request.files.add(await http.MultipartFile.fromPath(key, value.path));
        } else {
          request.fields[key] = value.toString();
        }
      });

      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('image', file.path));
      }

      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    logPrint("URL PARSE : ${Uri.parse("$kBaseUrl$endPoint$param")}");
    logPrint("$endPoint RESPONSE BODY : ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      logPrint('ERROR SERVICES ${response.body}');
      return {'success': false, 'message': response.reasonPhrase};
    }
  }

  
}
