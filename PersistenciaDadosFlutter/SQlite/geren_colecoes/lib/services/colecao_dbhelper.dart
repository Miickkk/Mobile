import '../models/colecao_model.dart';
import '../models/event_colecao_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ColecaoDBHelper {
  static Database? _database;

  static final ColecaoDBHelper _instance = ColecaoDBHelper._internal();

  ColecaoDBHelper._internal();
  factory ColecaoDBHelper() {
    return _instance;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "colecoes.db");

    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future<void> _onCreateDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS colecoes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        categoria TEXT NOT NULL,
        descricao TEXT NOT NULL,
        proprietario TEXT NOT NULL,
        valor_estimado REAL NOT NULL,
        item_raro INTEGER NOT NULL,
        local_armazenado TEXT NOT NULL
      )
    ''');

    print("Tabela colecoes criada");

    await db.execute('''
      CREATE TABLE IF NOT EXISTS eventos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        colecao_id INTEGER NOT NULL,
        data_hora_evento TEXT NOT NULL,
        tipo_evento TEXT NOT NULL,
        responsavel TEXT NOT NULL,
        local_evento TEXT NOT NULL,
        FOREIGN KEY (colecao_id) REFERENCES colecoes(id) ON DELETE CASCADE
      )
    ''');
    print("Tabela eventos criada");
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<int> insertColecao(Colecao colecao) async {
    final db = await database;
    return await db.insert("colecoes", colecao.toMap());
  }

  Future<List<Colecao>> getColecoes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "colecoes"
    );
    return maps.map((e) => Colecao.fromMap(e)).toList();
  }

  Future<Colecao?> getColecaoById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "colecoes", 
      where: "id = ?", 
      whereArgs: [id]
    );
    if (maps.isEmpty) {
      return null;
    } else {
      return Colecao.fromMap(maps.first);
    }
  }

  Future<int> deleteColecao(int id) async {
    final db = await database;
    return await db.delete("colecoes", where: "id = ?", whereArgs: [id]);
  }

  Future<int> insertEvento(EventoColecao evento) async {
    final db = await database;
    return await db.insert(
      "eventos", 
      evento.toMap(),
    );
  }

  Future<List<EventoColecao>> getEventosForColecao(int colecaoId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "eventos",
      where: "colecao_id = ?",
      whereArgs: [colecaoId],
      orderBy: "data_hora ASC",
    );
    return maps.map((e) => EventoColecao.fromMap(e)).toList();
  }

  Future<int> deleteEvento(int id) async {
    final db = await database;
    return await db.delete("eventos", where: "id = ?", whereArgs: [id]);
  }
}
