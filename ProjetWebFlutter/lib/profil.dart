import 'package:ProjetWebFlutter/user.dart';
import 'package:flutter/material.dart';
import 'package:ProjetWebFlutter/newNotice.dart';
import 'home.dart';
import 'dart:html';
import 'image.dart';

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
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Container(
                    height: 290.0,
                    width: 290.0,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        startWebFilePicker();
                      },
                      icon: Icon(
                        Icons.account_circle,
                        size: 80,
                      ),
                      shape: RoundedRectangleBorder(),
                      label: Text("Choisir une photo de profil"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Text(
                      "Information sur votre compte"
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}




