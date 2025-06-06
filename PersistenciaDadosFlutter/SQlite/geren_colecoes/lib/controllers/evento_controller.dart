import 'package:geren_colecoes/models/event_colecao_model.dart';
import 'package:geren_colecoes/services/colecao_dbhelper.dart';

class EventoController {
  final _dbHelper = ColecaoDBHelper();

  Future<int> createEvento(Evento evento) async {
    return _dbHelper.insertEvento(evento);
  }

  Future<List<Evento>> readEventosForColecao(int colecaoId) async {
    return _dbHelper.getEventosForColecao(colecaoId);
  }

  Future<int> deleteEvento(int id) async {
    return _dbHelper.deleteEvento(id);
  }
}