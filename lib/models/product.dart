import 'package:pharma/models/db.dart';

class Product {
  final int? id;
  final String? name;
  final double? pachat;
  final double? pvente;
  final String? description;
  final String? devise;


  const Product(
      {this.id, this.name, this.pachat, this.pvente, this.description,this.devise});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'pachat': pachat,
      'pvente': pvente,
      'description': description,
      'devise': devise,
    };
  }

  Map<String, dynamic> toMapWithId() {
    return {
      'name': name,
      'pachat': pachat,
       'pvente': pvente,
      'devise': devise,
    };
  }

  Future<Map<String, String>> addProduit() {
    Db db = Db();
    return db.add("medicament", toMap());
  }

  Object update() {
    Db db = Db();
    if (id != null) {
      return db.update("medicament", toMapWithId(), 'id=?', [id]);
    } else {
      return {
        "type": "failure",
        "message": "Echec de modification l'id est introuvable"
      };
    }
  }

  Object delete(myId) {
    Db db = Db();
    if (myId != null) {
      return db.delete("medicament", 'id=?', [myId]);
    } else {
      return {
        "type": "failure",
        "message": "Echec de suppression l'id est introuvable"
      };
    }
  }

  Future get() {
    Db db = Db();
    return db.fetch("SELECT * FROM medicament");
  }

  Future getById(myId) {
    Db db = Db();
    return db.fetch(
      "SELECT * FROM medicament where id=$myId",
    );
  }
  Future getLike(value) {
    Db db = Db();
    return db.fetch(
      "SELECT * FROM medicament where name like '%$value%'",
    );
  }
  Future getLimit() {
    Db db = Db();
    return db.fetch(
      "SELECT * FROM medicament  order by id desc limit 1",
    );
  }
}
