import 'dart:convert';

import 'package:FypProject/login.dart';
import 'package:FypProject/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'http_exception.dart';

class Authentication with ChangeNotifier {
  Future<void> SignUp(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCIfoRjwDnq0ZkIOABqVlMSIn1XytlCQJY';
     try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(response.body);
      //print(responseData);
      if (responseData['error'] != null) {
        throw Http_exception(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> LoginPage(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCIfoRjwDnq0ZkIOABqVlMSIn1XytlCQJY';

    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(response.body);
      //print(responseData);
      if (responseData['error'] != null) {
        throw Http_exception(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }
}
