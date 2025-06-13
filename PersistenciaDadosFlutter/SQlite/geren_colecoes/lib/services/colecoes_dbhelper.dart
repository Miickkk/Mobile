import 'package:geren_colecoes/models/colecoes_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/item_model.dart';
// Make sure the ItemModel class exists in the specified path and is exported from item_model.dart

class ColecoesDBHelper {
  static Database? _database;

  static final ColecoesDBHelper _instance = ColecoesDBHelper._internal();
  ColecoesDBHelper._internal();
  factory ColecoesDBHelper() {
    return _instance;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "colecao.db");

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreateDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<void> _onCreateDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE colecoes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        descricao TEXT,
        tipo_item TEXT 
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS itens(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        colecao_id INTEGER NOT NULL,
        nome TEXT,
        descricao TEXT,
        data_aquisicao TEXT,
        valor INT,
        condicao TEXT,
        foto TEXT,
        detalhe_especifico TEXT,
        FOREIGN KEY (colecao_id) REFERENCES colecoes(id) ON DELETE CASCADE
      )
    ''');
  }

  // CRUD Colecoes

  Future<int> insertColecao(Map<String, dynamic> colecao) async {
    final db = await getDatabase();
    return await db.insert("colecoes", colecao);
  }

  Future<List<Map<String, dynamic>>> getAllColecoes() async {
    final db = await getDatabase();
    return await db.query("colecoes");
  }

  Future<Map<String, dynamic>?> getColecaoById(int id) async {
    final db = await getDatabase();
    final results = await db.query("colecoes", where: "id = ?", whereArgs: [id]);
    if (results.isNotEmpty) return results.first;
    return null;
  }

  Future<int> updateColecao(int id, Map<String, dynamic> colecao) async {
    final db = await getDatabase();
    return await db.update("colecoes", colecao, where: "id = ?", whereArgs: [id]);
  }

  Future<int> deleteColecao(int id) async {
    final db = await getDatabase();
    return await db.delete("colecoes", where: "id = ?", whereArgs: [id]);
  }

  // CRUD Itens

  Future<int> insertItem(Map<String, dynamic> item) async {
    final db = await getDatabase();
    return await db.insert("itens", item);
  }

  Future<List<Map<String, dynamic>>> getItensByColecao(int colecaoId) async {
    final db = await getDatabase();
    return await db.query("itens", where: "colecao_id = ?", whereArgs: [colecaoId]);
  }

  Future<Map<String, dynamic>?> getItemById(int id) async {
    final db = await getDatabase();
    final results = await db.query("itens", where: "id = ?", whereArgs: [id]);
    if (results.isNotEmpty) return results.first;
    return null;
  }

  Future<int> updateItem(int id, Map<String, dynamic> item) async {
    final db = await getDatabase();
    return await db.update("itens", item, where: "id = ?", whereArgs: [id]);
  }

  Future<int> deleteItem(int id) async {
    final db = await getDatabase();
    return await db.delete("itens", where: "id = ?", whereArgs: [id]);
  }

  // Novo método readItemsByColecaoId retornando List<ItemModel>
  Future<List<ItemColecao>> readItemsByColecaoId(int colecaoId) async {
    final db = await getDatabase();
    final maps = await db.query(
      "itens",
      where: "colecao_id = ?",
      whereArgs: [colecaoId],
    );

    return List.generate(maps.length, (i) {
      return ItemColecao.fromMap(maps[i]);
    });
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < 2) {
    await db.execute('ALTER TABLE colecoes ADD COLUMN tipo_item TEXT');
  }
}
}
