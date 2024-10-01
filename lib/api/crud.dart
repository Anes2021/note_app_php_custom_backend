import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class Crud {
  void getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        log("Error catched: ${response.statusCode}");
      }
    } catch (e) {
      log("Error catched: ${e.toString()}");
    }
  }

  postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);

      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        log("Error catched: ${response.statusCode}");
      }
    } catch (e) {
      log("Error catched: ${e.toString()}");
    }
  }
}
