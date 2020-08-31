import 'dart:convert';
import 'dart:io';

import '../annonces.dart';
import '../user.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

var JWT = "" ;


class ApiServices {
  static Future<List<Annonce>> getAnnonces() async {
    final response =
  //  await http.get("https://next.json-generator.com/api/json/get/VJX9FVx1F");

  //  await http.get("https://webhook.site/93e4dd43-1476-4b9e-b94a-5660681be525");
//    await http.get("http://localhost:3000/annonces/all");
    await http.get(
      'https://findandtrade.herokuapp.com/annonces/all',
      headers: <String, String>{
        'Content-Type': 'application/json', 'x-access-token' : JWT
      },
    );


    if (response.statusCode != 200) {
      throw Error();
    }
    final jsonBody = json.decode(response.body);

    AnnonceJSON annonceJSON = AnnonceJSON.fromJson(jsonBody);
    print(annonceJSON);
    print(jsonBody);
    return annonceJSON.annonces;
  }




  static Future<void> createAnnonce(
      String title, String description, String type, String category, String photos, String loginUser) async {
    final response = await http.put(
      'https://findandtrade.herokuapp.com/annonces',
     // 'https://webhook.site/39c3d9a5-a5e1-451c-8bb0-8fe3775f89a1',
      headers: <String, String>{
        'Content-Type': 'application/json', 'x-access-token' : JWT
      },
      body: jsonEncode(
          <String, dynamic>{'title': title, 'description': description, 'username': loginUser, 'type': type, 'category': category, 'photos': photos}),
    );

    if (response.statusCode != 200) {
      throw Error();
    }
    final jsonBody = json.decode(response.body);
    print(jsonBody);
  }

  static Future<void> deleteAnnonce(String id) async {
    final response = await http.delete(
      //'https://findandtrade.herokuapp.com/annonces',
      'https://webhook.site/5c467738-1b0e-4824-aea0-40ddba9e259e',
      headers: <String, String>{
        'Content-Type': 'application/json', 'x-access-token' :  'https://findandtrade.herokuapp.com/annonces/${id}',
      },
    );

    if (response.statusCode != 200) {
      throw Error();
    }
    final jsonBody = json.decode(response.body);
    print(jsonBody);
  }

  // signIn
  static bool loginsuccess = false;

  static Future<void> login(
      String username, String password) async {
        final response = await http.post(
          'https://findandtrade.herokuapp.com/signin',
          //'https://next.json-generator.com/api/json/get/V1TcjPyjd',
          headers: <String, String>{
            'Content-Type': 'application/json'
          },
          body: jsonEncode(
              <String, dynamic>{'username': username, 'password': password}),
        );

        if (response.statusCode != 200) {
          throw Error();
        }

        final jsonBody = json.decode(response.body);
        final User token = User.fromJson(jsonBody);
        final User error = User.fromJson(jsonBody);

        if (error.error == null){
          loginsuccess = true;
        }
         else{
          loginsuccess = false;
        }
        JWT = token.token;
      }

  static Future<void> signup(
      String username, String password) async {
    final response = await http.post(
      'https://findandtrade.herokuapp.com/signup',
     // 'https://webhook.site/39c3d9a5-a5e1-451c-8bb0-8fe3775f89a1',
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
      body: jsonEncode(
          <String, dynamic>{'username': username, 'password': password}),
    );

    if (response.statusCode != 200) {
      throw Error();
    }

  }

  static Future<void> updateAnnonce(
      String phone, String ville, String email, String status_user) async {
    final response = await http.patch(
      //'https://findandtrade.herokuapp.com/users',
      'https://webhook.site/5c467738-1b0e-4824-aea0-40ddba9e259e',
      headers: <String, String>{
        'Content-Type': 'application/json', 'x-access-token' : JWT
      },
      body: jsonEncode(
          <String, dynamic>{'phone': phone, 'ville': ville, 'email': email, 'type': status_user}),
    );

    if (response.statusCode != 200) {
      throw Error();
    }
    final jsonBody = json.decode(response.body);
    print(jsonBody);
  }
}


