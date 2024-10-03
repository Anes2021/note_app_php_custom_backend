import 'dart:convert';
import 'dart:developer';

import 'package:flutter_session_manager/flutter_session_manager.dart';
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

  Future<dynamic> postRequestAndCreateToken(String url, Map data) async {
    try {
      // Make the POST request
      var response = await http.post(Uri.parse(url), body: data);

      // If the response is successful
      if (response.statusCode == 200) {
        // Decode the response body
        var responseBody = jsonDecode(response.body);

        // Assuming the token is in the response headers
        String? token = response.headers['authorization'];

        if (token != null && token.startsWith('Bearer ')) {
          // Extract the actual token
          token = token.substring(7);

          // Save the token using flutter_session_manager
          await SessionManager().set('token', token);

          // Proceed after saving the token (e.g., navigate or log success)
          log('Login successful, token saved: $token');
        } else {
          log('No valid token received from server.');
        }

        return responseBody;
      } else {
        // If there's an error response from the server, log it
        log("Error caught: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch and log any errors during the request
      log("Error caught: ${e.toString()}");
      return null;
    }
  }
}
