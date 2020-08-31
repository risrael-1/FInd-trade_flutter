import 'package:ProjetWebFlutter/user.dart';
import 'package:flutter/material.dart';
import 'package:ProjetWebFlutter/newNotice.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'annonces.dart';
import 'home.dart';
import 'dart:html';
import 'image.dart';
import 'package:ProjetWebFlutter/service/apiService.dart';

class ProfilPage extends StatelessWidget {
  final User userAdmin;
  final String userToken;

  const ProfilPage({Key key, this.userAdmin, this.userToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 0.0,
        height: 0.0,
        child: _buildContent(userAdmin, userToken, context)
    );
  }


  Widget _buildContent(User user, String userToken, BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController ville = TextEditingController();
    TextEditingController typeUser = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Profil'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              tooltip: 'Accueil',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        HomePage(
                          userAdmin: user,
                          userToken: userToken,
                        )
                ));
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Créer une annonce',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        NewNotice(
                          userAdmin: user,
                          userToken: userToken,
                        )
                ));
              },
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              tooltip: 'Profil',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        ProfilPage(
                          userAdmin: user,
                          userToken: userToken,
                        )
                ));
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings_power),
              tooltip: 'Déconnexion',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signin');
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(50),
          child: ListView(
            children: <Widget>[
              Center(
                child: Text(
                    'Nom d\'utilisateur : ipad',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(150, 30, 150, 20),
                child: TextField(
                  controller: phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Téléphone',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(150, 30, 150, 20),
                child: TextField(
                  controller: ville,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ville',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(150, 30, 150, 20),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(150, 30, 150, 20),
                child: TextField(
                  controller: typeUser,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Type d\'utilisateur',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50),
                child: Container(
                    height: 70,
                    width: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Center(
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.green,
                        child: Text('Modifier'),
                        onPressed: () {
                          if(phone.text == '' || ville.text == '' || email.text == '' || typeUser.text == ''){
                            Fluttertoast.showToast(
                            msg: "Veuillez renseigner tous les champs",
                            timeInSecForIosWeb: 2,
                          );
                          } else {
                            print('username : ' + user.username);
                            ApiServices.updateAnnonce(
                                phone.text, ville.text, email.text,
                                typeUser.text);
                          }
                        }
                    )),
                )),

            ],
          ),
        ),
    );
  }
}




