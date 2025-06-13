import 'package:geren_colecoes/services/colecoes_dbhelper.dart';
import 'package:geren_colecoes/models/item_model.dart';

class ItemColecaoController {
  final ColecoesDBHelper _dbHelper = ColecoesDBHelper();

  Future<ItemColecao?> readItemById(int id) async {
    final map = await _dbHelper.getItemById(id);
    if (map != null) {
      return ItemColecao.fromMap(map);
    }
    return null;
  }

  Future<List<ItemColecao>> readItemsByColecaoId(int colecaoId) async {
    final listMaps = await _dbHelper.getItensByColecao(colecaoId);
    return listMaps.map((map) => ItemColecao.fromMap(map)).toList();
  }

  Future<int> deleteItem(int id) async {
    return await _dbHelper.deleteItem(id);
  }

  Future<int> createItemColecao(ItemColecao item) async {
    final id = await _dbHelper.insertItem(item.toMap());
    return id;
  }
}
