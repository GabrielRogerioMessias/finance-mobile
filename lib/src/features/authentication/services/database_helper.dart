import 'package:finance_mobile/src/features/authentication/models/dispesa_model.dart';
import 'package:finance_mobile/src/features/authentication/models/entrada_model.dart';
import 'package:finance_mobile/src/features/authentication/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "finance.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
          // Criação da tabela User
          await db.execute(
              "CREATE TABLE User(user_id INTEGER PRIMARY KEY, name TEXT NOT NULL, email TEXT NOT NULL, password TEXT NOT NULL);");

          // Criação da tabela Categoria
          await db.execute(
              "CREATE TABLE Categoria(categoria_id INTEGER PRIMARY KEY, userId INTEGER, name TEXT NOT NULL, FOREIGN KEY(userId) REFERENCES User(user_id));");

          // Criação da tabela Entrada
          await db.execute(
              "CREATE TABLE Entrada(entrada_id INTEGER PRIMARY KEY, userId INTEGER, categoriaId INTEGER, data_entrada DATE, valor_entrada REAL, descricao_entrada TEXT, FOREIGN KEY(userId) REFERENCES User(user_id), FOREIGN KEY(categoriaId) REFERENCES Categoria(categoria_id));");

          // Criação da tabela Dispesa
          await db.execute(
              "CREATE TABLE Dispesa(dispesa_id INTEGER PRIMARY KEY, userId INTEGER, categoriaId INTEGER, data_despesa DATE, valor_despesa REAL, FOREIGN KEY(userId) REFERENCES User(user_id), FOREIGN KEY(categoriaId) REFERENCES Categoria(categoria_id));");
        },
        version: _version
    );
  }

  //add user
  static Future<int> addUser(User user) async {
    final db = await _getDB();
    return await db.insert("User", user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //delete user
  static Future<int> deleteUser(int userId) async {
    final db = await _getDB();
    return await db.delete("User", where: "user_id = ?", whereArgs: [userId]);
  }


  //add
  static Future<int> addEntrada(Entrada entrada) async {
    final db = await _getDB();
    return await db.insert("Entrada", entrada.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> addDispesa(Dispesa dispesa) async {
    final db = await _getDB();
    return await db.insert("Dispesa", dispesa.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //delete
  static Future<int> deleteEntrada(int id) async {
    final db = await _getDB();
    return await db.delete("Entrada", where: "entrada_id = ?", whereArgs: [id]);
  }

  static Future<int> deleteDispesa(int id) async {
    final db = await _getDB();
    return await db.delete("Dispesa", where: "dispesa_id = ?", whereArgs: [id]);
  }

  //update
  static Future<int> updateEntrada(Entrada entrada) async {
    final db = await _getDB();
    return await db.update("Entrada", entrada.toJson(),
        where: "entrada_id = ?", whereArgs: [entrada.entrada_id]);
  }

  static Future<int> updateDispesa(Dispesa dispesa) async {
    final db = await _getDB();
    return await db.update("Dispesa", dispesa.toJson(),
        where: "dispesa_id = ?", whereArgs: [dispesa.dispesa_id]);
  }

}
