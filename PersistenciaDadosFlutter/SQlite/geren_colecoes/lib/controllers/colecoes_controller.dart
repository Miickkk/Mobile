import 'package:geren_colecoes/services/colecoes_dbhelper.dart';

import '../models/colecoes_model.dart';

class ColecoesController {
  final ElemtShopDBHelper _dbHelper = ElemtShopDBHelper();


  Future<int> createColecao(Colecao colecao) async{
    return _dbHelper.insertColecao(colecao);
  }

  Future<List<Colecao>> readColecoes() async{
    return _dbHelper.getColecoes();
  }

  Future<Colecao?> readColecaoById(int id) async{
    return _dbHelper.getColecaoById(id);
  }

  Future<int> deleteColecao(int id) async{
    return _dbHelper.deleteColecao(id);
  }
}