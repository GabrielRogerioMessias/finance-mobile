import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'MyFinanceApp.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future _createDatabase(Database db, int version) async {
    await db.execute("CREATE TABLE User("
        "user_id INTEGER PRIMARY KEY AUTOINCREMENT,"
        " name TEXT NOT NULL,"
        " email TEXT NOT NULL,"
        " password TEXT NOT NULL)");
    await db.execute("CREATE TABLE Categoria("
        "categoria_id INTEGER PRIMARY KEY AUTOINCREMENT,"
        " userId INTEGER,"
        " name TEXT NOT NULL,"
        " FOREIGN KEY(userId) REFERENCES User(user_id));");
    await db.execute("CREATE TABLE Transacao("
        "transacao_id INTEGER PRIMARY KEY AUTOINCREMENT,"
        " userId INTEGER,"
        " categoriaId INTEGER,"
        " data_entrada DATE,"
        " valor_entrada REAL,"
        " descricao TEXT NOT NULL,"
        " FOREIGN KEY(userId) REFERENCES User(user_id),"
        " FOREIGN KEY(categoriaId) REFERENCES Categoria(categoria_id));");

  }

  // ----------------------------- METODOS DO USUARIO --------------------------------------

  //Registro do usuario
  Future<int> registerUser(String name, String email, String password) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert(
        'User', {'name': name, 'email': email, 'password': password},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Confirmar se o email ja existe ou não
  Future<bool> isEmailAlreadyInUse(String email) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result =
    await db.query('User', where: 'email = ?', whereArgs: [email]);
    return result.isNotEmpty;
  }

  //autenticação do usuário
  Future<bool> authenticateUser(String email, String password) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query('User',
        where: 'email = ? AND password = ?', whereArgs: [email, password]);

    return result.isNotEmpty;
  }

  //Nova senha
  Future<void> resetPassword(String email, String newPassword) async {
    Database db = await instance.database;
    await db.update('User', {'password': newPassword}, where: 'email = ?',
      whereArgs: [email],
    );
  }

  Future<Map<String, dynamic>?> retrieveUserIdAndName(String email) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
        'User', where: 'email =?', whereArgs: [email]);
    if (result.isNotEmpty) {
      return {'user_id': result.first['user_id'], 'name': result.first['name']};
    }
    return null;
  }

}
