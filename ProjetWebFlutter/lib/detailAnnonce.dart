import 'package:flutter/material.dart';
import 'package:ProjetWebFlutter/profil.dart';
import 'home.dart';
import 'newNotice.dart';
import 'annonces.dart';
import 'package:ProjetWebFlutter/user.dart';
import 'main.dart';
import 'package:ProjetWebFlutter/service/apiService.dart';

class DetailAnnonce extends StatelessWidget {
  final User userAdmin;
  final String userToken;
  final Annonce annonce;
  const DetailAnnonce({Key key, this.userAdmin, this.userToken, this.annonce}) : super(key: key);

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
          centerTitle: true,
          title: const Text('Détail'),
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
                  'Détail de l\'annonce',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    "Nom de l'article : " + annonce.title,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Image.network(
                    annonce.photos,
                    scale: 2,
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Description du produit : " + annonce.description +
                      "\n\nCatégorie du produit : " + annonce.category +
                      "\n\nCe produit est de type : " + annonce.type +
                      "\n\nCe produit à été ajouté le : " + annonce.createdAt +
                      "\n\nPar : " + annonce.username,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            if(annonce.username == loginUser)
              Container(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: IconButton(
                        onPressed: () {
                          print(annonce.id);
                          ApiServices.deleteAnnonce(annonce.id);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )

                    )
                ),
              ),
          ],
        ),
      ),
    );
  }
}




/**class detailAnnonce extends StatelessWidget {
  final Annonce annonce;
  final String jwt;

  const detailAnnonce({
    Key key,
    this.annonce,
    this.jwt
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Détail'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              tooltip: 'Accueil',
              onPressed: () {
                home((context));
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Créer une annonce',
              onPressed: () {
                NewNotice(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              tooltip: 'Profil',
              onPressed: () {
                profil(context);
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
                  'Détail de l\'annonce',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    "Nom de l'article : " + annonce.title,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Image.network(
                    annonce.photos,
                    scale: 2,
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Description du produit : " + annonce.description +
                      "\n\nCatégorie du produit : " + annonce.category +
                      "\n\nCe produit est de type : " + annonce.type +
                      "\n\nCe produit à été ajouté le : " + annonce.createdAt,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );;
  }
}**/
