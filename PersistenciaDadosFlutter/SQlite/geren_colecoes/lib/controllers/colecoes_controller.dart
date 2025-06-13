import 'package:geren_colecoes/models/colecoes_model.dart';
import 'package:geren_colecoes/services/colecoes_dbhelper.dart';

class ColecoesController {
  final dbHelper = ColecoesDBHelper();

  Future<void> createColecao(Colecao colecao) async {
    final db = await dbHelper.getDatabase();
    await db.insert('colecoes', colecao.toMap());
  }

  Future<List<Colecao>> readAllColecoes() async {
    final db = await dbHelper.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('colecoes');
    return maps.map((map) => Colecao.fromMap(map)).toList();
  }

  Future<void> deleteColecao(int id) async {
    final db = await dbHelper.getDatabase();
    await db.delete('colecoes', where: 'id = ?', whereArgs: [id]);
  }
}