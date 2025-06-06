class Colecao {
  final int? id;
  final String titulo;
  final String categoria;
  final String descricao;
  final String proprietario;
  final String valorEstimado;
  final bool itemRaro;
  final String localArmazenado;

  Colecao({
    this.id,
    required this.titulo,
    required this.categoria,
    required this.descricao,
    required this.proprietario,
    required this.valorEstimado,
    required this.itemRaro,
    required this.localArmazenado,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "titulo": titulo,
      "categoria": categoria,
      "descricao": descricao,
      "proprietario": proprietario,
      "valor_estimado": valorEstimado,
      "item_raro": itemRaro ? 1 : 0,
      "local_armazenado": localArmazenado,
    };
  }

  factory Colecao.fromMap(Map<String, dynamic> map) {
    return Colecao(
      id: map["id"] as int?,
      titulo: map["titulo"] as String,
      categoria: map["categoria"] as String,
      descricao: map["descricao"] as String,
      proprietario: map["proprietario"] as String,
      valorEstimado: map["valor_estimado"] as String,
      itemRaro: map["item_raro"] == 1,
      localArmazenado: map["local_armazenado"] as String,
    );
  }
}
