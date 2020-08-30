import 'dart:convert';

import '../annonces.dart';
import '../user.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<Annonce>> getAnnonces() async {
    final response =
    await http.get("https://next.json-generator.com/api/json/get/VJX9FVx1F");
    //await http.get("http://findandtrade.herokuapp.com/annonces/all");
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

  /**static Future<http.Response> createAnnonce(String title, String description, String category, String type) async {
    final http.Response response = await http.post(
      'https://webhook.site/030ccf56-c5cf-4890-b93b-2e3bf2a236a5',
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'description': description,
        'category': category,
        'type': type
      })
    );
    if(response.statusCode == 201) {
      return Annonce.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erreur');
    }
  }**/


  // signIn
  // Nous avons besoin du headers mettre le Content-Type
  static Future<String> connectProfile(String username, String password) async {
    final response_signin = await http.post(
      "https://findandtrade.herokuapp.com/signin",
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


