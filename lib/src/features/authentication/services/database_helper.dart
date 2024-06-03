import 'package:finance_mobile/src/features/finance/models/transacao_model.dart';
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
    String path = join(await getDatabasesPath(), 'FinanceDB.db');
    return await openDatabase(
      path,
      version: 4,
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
        " tipo_transacao BOOLEAN,"
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

  Future<bool> checkIfEmailExist(String email) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps =
        await db.query('User', where: 'email =?', whereArgs: [email]);
    return maps.isNotEmpty;
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
    await db.update(
      'User',
      {'password': newPassword},
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  //recuperar id e email do usuario
  Future<Map<String, dynamic>?> retrieveUserIdAndName(String email) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result =
        await db.query('User', where: 'email =?', whereArgs: [email]);
    if (result.isNotEmpty) {
      return {'user_id': result.first['user_id'], 'name': result.first['name']};
    }
    return null;
  }

  //fazer logout da conta
  Future<void> logoutUser(String email) async {
    Database db = await instance.database;
    await db.delete('User', where: 'email =?', whereArgs: [email]);
  }

  //insirir transacoes
  Future<int> insertTransaction(Map<String, dynamic> transaction) async {
    Database db = await instance.database;
    return await db.insert(
      'Transacao',
      transaction,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //recuperar as transacoes
  Future<List<Transacao>> getTransactions(int userId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'Transacao',
      where: 'userId =?',
      whereArgs: [userId],
    );

    return result.map((map) => Transacao.fromMap(map)).toList();
  }

  //recuperar os dados de acordo com id do usuario
  Future<List<Map<String, dynamic>>> getTransacoesByUserId(int userId) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'Transacao',
      where: 'userId =?',
      whereArgs: [userId],
    );
    return result;
  }

  //deletar transacoes
  Future<void> deleteTransaction(int transacaoId) async {
    Database db = await instance.database;
    await db.delete(
      'Transacao',
      where: 'transacao_id =?',
      whereArgs: [transacaoId],
    );
  }

  //editar transacoes
  Future<int> updateTransaction(Map<String, dynamic> transaction) async {
    Database db = await instance.database;
    int id = transaction['transacao_id'];
    return await db.update(
      'Transacao',
      transaction,
      where: 'transacao_id = ?',
      whereArgs: [id],
    );
  }
}
