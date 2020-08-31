import 'dart:async';

import 'package:ProjetWebFlutter/service/apiService.dart';
import 'package:ProjetWebFlutter/user.dart';
import 'package:flutter/material.dart';
import 'package:ProjetWebFlutter/newAccount.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show ascii, base64, json, jsonDecode;

import 'service/apiService.dart';
import 'service/apiService.dart';
import 'service/apiService.dart';
import 'service/apiService.dart';
import 'service/apiService.dart';
import 'service/apiService.dart';

const SERVER_IP = 'http://findandtrade.herokuapp.com';
final storage = FlutterSecureStorage();

var loginUser;

void main() {
  runApp(MyApp());
}

void displayDialog(BuildContext context, String title, String text) =>
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
              title: Text(title),
              content: Text(text)
          ),
    );

Future<String> attemptLogIn(String username, String password) async {
  var res = await http.post(
      "$SERVER_IP/signin",
      body: {
        "username": username,
        "password": password
      }
  );
  if(res.statusCode == 200) return res.body;
  return null;
}




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/signin',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/signin': (_) => MyHomePage(),
        },
        title: 'Find & Trade',
        theme: ThemeData(
          primarySwatch: Colors.green,
       //   visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(
          title: 'Find & Trade',
        ));
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Find and trade')),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
            padding: EdgeInsets.all(50),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Connexion',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(150, 30, 150, 20),
                        child: TextFormField(
                          validator: (value) {
                          if (value.isEmpty) {
                            return 'Vous devez entrer un votre pseudo';
                          }
                          return null;
                        },
                          controller: nameController,

                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nom d\'utilisateur',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(150, 10, 150, 20),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Vous devez entrer un mot de passe';
                            }
                            if (input.length < 3) {
                              return 'Votre mot de passe est trop petit';
                            } else if (input.length > 18) {
                              return 'Votre mot de passe est trop grand';
                            }
                            return null;
                          },
                          obscureText: true,
                          controller: passwordController,

                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mot de passe',
                          ),
                        ),
                      )
                    ],
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Center(
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.green,
                          child: Text('Valider'),
                          onPressed: () async {
                            if(nameController.text == "" || passwordController.text == ""){
                              Fluttertoast.showToast(
                                msg: "Veuillez renseigner tous les champs",
                                timeInSecForIosWeb: 2,
                              );
                            }
                            else {
                              loginUser = nameController.text;
                              ApiServices.login(
                                  nameController.text, passwordController.text
                              );


                              String A = "Connexion échouée veuillez verifier vos identifiants" ;
                              String B = "Connexion réussie" ;

                              Timer(Duration(seconds: 1), () {

                                var logsuccess = ApiServices.loginsuccess;

                                if (logsuccess){
                                  String A = B;
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage(userToken: null, userAdmin: null)
                                  ));
                                }

                              });


                              Timer(Duration(seconds: 2), () {

                                var logsuccess = ApiServices.loginsuccess;
                                if(logsuccess){
                                 A = B;
                                }
                                Fluttertoast.showToast(
                                  msg: A ,
                                  timeInSecForIosWeb: 2,
                                );
                              });

                            }
                            //logIn(context, nameController, passwordController);

                          },
                        ),
                      )),
                ),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('Vous n\'avez pas de compte ?'),
                        FlatButton(
                          textColor: Colors.green,
                          child: Text(
                            'S\'inscrire',
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            newAccount(context);
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )));
  }

}