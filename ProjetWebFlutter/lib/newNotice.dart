import 'package:ProjetWebFlutter/main.dart';
import 'package:flutter/material.dart';
import 'package:ProjetWebFlutter/profil.dart';
import 'home.dart';
import 'image.dart';
import 'package:ProjetWebFlutter/user.dart';
import 'service/apiService.dart';
import 'package:material_segmented_control/material_segmented_control.dart';


class NewNotice extends StatelessWidget {
  final User userAdmin;
  final String userToken;

  const NewNotice({Key key, this.userAdmin, this.userToken})
      : super(key: key); // Option 2

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 0.0,
        height: 0.0,
        child: _buildContent(userAdmin, userToken, context)
    );
  }


  Widget _buildContent(User user, String userToken, BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController categorie = TextEditingController();
    TextEditingController imageUrl = TextEditingController();
    bool monVal = false;
    bool tuVal = false;
    bool wedVal = false;
    String type = "";
    List<String> _locations = ['Echanges', 'Dons']; // Option 2
    String _selectedLocation;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Ajouter une annonce'),
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
          ]
      ),
      body: Padding(
        padding: EdgeInsets.all(50),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Nouvelle annonce',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )
            ),
            Container(
              padding: EdgeInsets.fromLTRB(150, 30, 150, 20),
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Titre',
                ),
              ),
            ),
            Center(
              child: DropdownButton<String>(
                hint: Text("Choisissez un type"),
                items: <String>['Echanges', 'Dons'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (String newValue) {
                },
              ),
            ),
            Center(
              child: DropdownButton<String>(
                hint: Text("Choisissez une categorie"),
                items: <String>['Animaux', 'Bricolage', 'Electroménager', 'Informatique', 'Instruments de Musique', 'Jardinage', 'Jeux & Jouets', 'Mobilier', 'Multimédia', 'Sport', 'Véhicules', 'Vêtements'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (String newvalue) {

                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(150, 30, 150, 20),
              child: TextField(
                controller: description,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(150, 30, 150, 20),
              child: TextField(
                controller: imageUrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Url de l\'image',
                ),
              ),
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
                      child: Text('Ajouter'),
                      onPressed: () {
                        print(title.text);
                        ApiServices.createAnnonce(
                            title.text, description.text,loginUser
                        );
                      },
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}