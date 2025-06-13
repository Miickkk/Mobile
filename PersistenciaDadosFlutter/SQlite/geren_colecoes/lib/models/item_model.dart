class ItemColecao {
  final int? id; // id gerado automaticamente
  final int colecaoId; // chave estrangeira (relaciona com Colecao)
  final String nome;
  final String descricao;
  final DateTime dataAquisicao;
  final int valor;
  final String condicao;
  final String? foto; // caminho ou URL da imagem
  final String detalheEspecifico; // Ex: país da moeda

  ItemColecao({
    this.id,
    required this.colecaoId,
    required this.nome,
    required this.descricao,
    required this.dataAquisicao,
    required this.valor,
    required this.condicao,
    this.foto,
    required this.detalheEspecifico,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'colecao_id': colecaoId,
      'nome': nome,
      'descricao': descricao,
      'data_aquisicao': dataAquisicao.toIso8601String(),
      'valor': valor,
      'condicao': condicao,
      'foto': foto,
      'detalhe_especifico': detalheEspecifico,
    };
  }

  factory ItemColecao.fromMap(Map<String, dynamic> map) {
    return ItemColecao(
      id: map['id'] as int?,
      colecaoId: map['colecao_id'] as int,
      nome: map['nome'] as String,
      descricao: map['descricao'] as String,
      dataAquisicao: DateTime.parse(map['data_aquisicao'] as String),
      valor: (map['valor'] as num).toInt(),
      condicao: map['condicao'] as String,
      foto: map['foto'] as String?,
      detalheEspecifico: map['detalhe_especifico'] as String,
    );
  }

  // Formatação manual da data no estilo dd/MM/yyyy
  String get dataFormatada {
    final dia = dataAquisicao.day.toString().padLeft(2, '0');
    final mes = dataAquisicao.month.toString().padLeft(2, '0');
    final ano = dataAquisicao.year.toString();
    return "$dia/$mes/$ano";
  }
}
