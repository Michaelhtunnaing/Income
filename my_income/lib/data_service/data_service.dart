import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utils/apistatus.dart';

class DataService {
  Future<Object> getMatch(String url) async {
    try {
      var client = http.Client();
      Uri uri = Uri.parse(url);
      var response = await client.get(uri).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        String jsonData = response.body;
        return Success(code: 200, response: jsonData);
      } else {
        return Failure(code: 202, response: "Data Fetching Error!");
      }
    } on SocketException {
      return Failure(code: 404, response: "Internet Connection Down!");
    } on ClientException {
      return Failure(code: 202, response: "HTTP request failed!");
    } on FormatException {
      return Failure(code: 203, response: "Json Format Error!");
    } on TimeoutException {
      return Failure(code: 204, response: "Request timed out!");
    } catch (e) {
      return Failure(code: 205, response: "Unknown Error!");
    }
  }
}
