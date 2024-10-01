import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class Crud {
  Future<dynamic> getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        log("Error caught: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("Error caught: ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        log("Error caught: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("Error caught: ${e.toString()}");
      return null;
    }
  }
}
