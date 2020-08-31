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
    //await http.get("http://findandtrade.herokuapp.com/annonces/all");
  //  await http.get("https://webhook.site/93e4dd43-1476-4b9e-b94a-5660681be525");
    await http.get("http://localhost:3000/annonces/all");

    if (response.statusCode != 200) {
      throw Error();
    }
    final jsonBody = json.decode(response.body);
    print("tableau d'annonces");

    AnnonceJSON annonceJSON = AnnonceJSON.fromJson(jsonBody);
    print(annonceJSON);
    print(jsonBody);
    return annonceJSON.annonces;
  }




  static Future<void> createAnnonce(
      String title, String description, String loginUser) async {
    final response = await http.put(
      'https://webhook.site/39c3d9a5-a5e1-451c-8bb0-8fe3775f89a1',
      headers: <String, String>{
        'Content-Type': 'application/json', 'x-access-token' : JWT
      },
      body: jsonEncode(
          <String, dynamic>{'title': title, 'description': description, 'username': loginUser, 'type': 'don', 'category':'Jardinage', 'photos': 'https://www.jardiner-malin.fr/wp-content/uploads/2020/03/Coronavirus-jardinage.jpg'}),
    );

    if (response.statusCode != 200) {
      throw Error();
    }
    final jsonBody = json.decode(response.body);
    print(jsonBody);
  }

  // signIn

  static Future<void> login(
      String username, String password) async {
    final response = await http.post(
      'https://findandtrade.herokuapp.com/signin',
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
    print(jsonBody);
   // print(jsonBody);
    final User token = User.fromJson(jsonBody);
   print(token.token);
    JWT = token.token;
  }

  static Future<String> connectProfile(String username, String password) async {
    final response_signin = await http.post(
      "https://webhook.site/39c3d9a5-a5e1-451c-8bb0-8fe3775f89a1",
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{'username': username, 'password': password}),
    );
    if (response_signin.statusCode == 200) {
      return response_signin.body.toString();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<User> fetchProfile(String token) async {
    final response = await http.post(
        'https://findandtrade.herokuapp.com/signin',
        headers: {"x-access-token": token});

    if (response.statusCode == 200) {
      Map profileMap = jsonDecode(response.body);
      var profile = User.fromJson(profileMap['message']);
      return profile;
    } else {
      return null;
    }
  }
}


