import 'package:geren_colecoes/services/colecao_dbhelper.dart';

import '../models/colecao_model.dart';

class ColecaoController {
  final ColecaoDBHelper _dbHelper = ColecaoDBHelper();

  Future<int> createColecao(Colecao colecao) async {
    return _dbHelper.insertColecao(colecao);
  }

  Future<List<Colecao>> readColecoes() async {
    return _dbHelper.getColecoes();
  }

  Future<Colecao?> readColecaoById(int id) async {
    return _dbHelper.getColecaoById(id);
  }

  Future<int> deleteColecao(int id) async {
    return _dbHelper.deleteColecao(id);
  }
}
