import 'package:geren_colecoes/models/colecoes_model.dart';
import 'package:geren_colecoes/services/colecoes_dbhelper.dart';


class ElemController {
  final _dbHelper = ElemtShopDBHelper();


  Future<int> createElem(Elemt elem) async{
    return _dbHelper.insertElem(elem);
  }

  Future<List<Elemt>> readElemForColecao(int colecaoId) async{
    return _dbHelper.getElemForColecao(colecaoId);
  }

  Future<int> deleteElem(int id) async{
    return _dbHelper.deleteElem(id);
  }
}