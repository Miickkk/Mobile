import 'package:intl/intl.dart';

class EventoColecao {
  final int? id;
  final int colecaoId;
  final DateTime dataHoraEvento;
  final String tipoEvento;
  final String responsavel;
  final String localEvento;

  EventoColecao({
    this.id,
    required this.colecaoId,
    required this.dataHoraEvento,
    required this.tipoEvento,
    required this.responsavel,
    required this.localEvento,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "colecao_id": colecaoId,
      "data_hora_evento": dataHoraEvento.toIso8601String(),
      "tipo_evento": tipoEvento,
      "responsavel": responsavel,
      "local_evento": localEvento,
    };
  }

  factory EventoColecao.fromMap(Map<String, dynamic> map) {
    return EventoColecao(
      id: map["id"] as int?,
      colecaoId: map["colecao_id"] as int,
      dataHoraEvento: DateTime.parse(map["data_hora"] as String),
      tipoEvento: map["tipo_evento"] as String,
      responsavel: map["responsavel"] as String,
      localEvento: map["local_evento"] as String,
    );
  }

  String get dataHoraFormatada {
    final DateFormat formatter = DateFormat("dd/MM/yyyy HH:mm");
    return formatter.format(dataHoraEvento);
  }
}
