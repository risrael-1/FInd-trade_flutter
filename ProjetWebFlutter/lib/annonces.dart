import 'package:flutter/cupertino.dart';

class AnnonceJSON {

  final String error;
  final List<Annonce> annonces;

  AnnonceJSON(this.error, this.annonces);

  factory AnnonceJSON.fromJson(Map<String, dynamic> json) {
    var list = json['annonces'] as List;
    print(list.runtimeType);
    List<Annonce> annoncesList = list.map((i) => Annonce.fromJson(i)).toList();

    return AnnonceJSON(
        json["error"],
        annoncesList
    );
  }
}


class Annonce {

  final String _id;
  final String userID;
  final String username;
  final String title;
  final String description;
  final String category;
  final String type;
  final String createdAt;
  final String photos;
  final String lastUpdatedAt;

  Annonce(this._id, this.userID, this.username, this.title, this.description, this.category, this.type ,this.createdAt, this.photos, this.lastUpdatedAt) ;

  factory Annonce.fromJson(Map<String, dynamic> json) {
    return Annonce(
        json["_id"],
        json["userID"],
        json["username"],
        json["title"],
        json["description"],
        json["category"],
        json["type"],
        json["createdAt"],
        json["photos"],
        json["lastUpdatedAt"]
    );
  }
}

