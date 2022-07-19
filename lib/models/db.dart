import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class Db{
  static final Db instance= Db._instance();
  static Database database=Null as Database;
  Db._instance();

  /// constructeur null
  Db();

  /// initialisation de la base de donnees
  Future<Database> get db async{
    database = await createDatabase();
    return database;
  }

  /// creation de la base de bonnees et ouverture de connection
  createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'pharma.db');
    var database = await openDatabase(path, version: 1, onCreate: dbTables);
    return database;
  }

  /// creation des tables
  void dbTables(Database database, int version) async {
    /// table configuration general
    await database.execute(
        'CREATE TABLE medicament(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL,pachat REAL not null,pvente REAL not null, description TEXT NOT NULL, devise TEXT NOT NULL );');
  }

  /// cette methode [add] permet d'ajouter une nouvelle occurence
  /// * @param @String [table] le nom de la table
  /// * @param @list [field] une liste de colonne
  /// * @param @list [value] une liste de valeurs
  /// * @return @Map un dictionaire : type et message
  ///  "type":"success" si l'enregistrement s'est bien effectuer
  ///  "type":"failure" Dans le cas de l'eche d'enregistrement
  Future<Map<String, String>> add(
      String table, Map<String, Object?> values) async {
    Database db = await this.db;
    final int result = await db.insert(table, values,
        conflictAlgorithm: ConflictAlgorithm.replace);
    if (result > 0) {
      return {"type": "success", "message": "Enregistrement effectuer"};
    } else {
      return {"type": "failure", "message": "Echec d'enregistrement"};
    }
  }

  /// cette methode [update] permet la modification d'une occurence
  /// * @param @String [query] la requette
  /// * @param @list [value] une liste de valeur
  /// * @return @Map un dictionaire : type et message
  ///  "type":"success" si l'enregistrement s'est bien effectuer
  ///  "type":"failure" Dans le cas de l'eche d'enregistrement
  Future<Map<String, String>> update(String table, Map<String, Object?> values,
      String? where, List<Object?>? whereArgs) async {
    Database db = await this.db;
    final int result =
        await db.update(table, values, where: where, whereArgs: whereArgs);
    if (result > 0) {
      return {"type": "success", "message": "Modification effectuer"};
    } else {
      return {"type": "failure", "message": "Quelque chose s'est mal passé"};
    }
  }

  /// cette methode [fetch] permet selectionner des element
  /// * @param @String [query] la requette d'insertion
  /// * @return @Map un dictionaire : type et message
  ///  "type":"success" si la requette s'est bien effectuer
  ///  "type":"failure" Dans le cas de l'eche d'enregistrement
  Future<Map<String, dynamic>> fetch(String query) async {
    Database db = await this.db;
    var result = await db.rawQuery(query);
    if (result.isNotEmpty) {
      return {"type": "success", "message": result.toList()};
    } else {
      return {"type": "failure", "message": "Quelque chose s'est mal passé"};
    }
  }

  /// cette methode [delete] permet de supprimer une occurence
  /// * @param @String [query] la requette de suppression
  /// * @return @Map un dictionaire : type et message
  ///  "type":"success" si la requette s'est bien effectuer
  ///  "type":"failure" Dans le cas de l'eche d'enregistrement
  Future<Map<String, String>> delete(
      String table, String? where, List<Object?>? whereArgs) async {
    Database db = await this.db;
    final int result =
        await db.delete(table, where: where, whereArgs: whereArgs);
    if (result > 0) {
      return {"type": "success", "message": "Suppression effectuer"};
    } else {
      return {"type": "failure", "message": "Quelque chose s'est mal passé"};
    }
  }
}
