class Colecao{
  final int? id; 
  final String nome;
  final String descricao;
  final String tipo;
  final Number valor;

  Colecao({
    this.id,
    required this.nome,
    required this.descricao,
    required this.tipo,
    required this.valor
  });

  Map<String,dynamic> toMap(){
    return{
      "id": id,
      "nome":nome,
      "descricao":raca,
      "nome_dono": nomeDono,
      "telefone_dono": telefoneDono
    };
  }

  factory Pet.fromMap(Map<String,dynamic> map) {
    return Pet(
      id:map["id"] as int,
      nome: map["nome"] as String, 
      raca: map["raca"] as String, 
      nomeDono: map["nome_dono"] as String, 
      telefoneDono: map["telefone_dono"] as String);
  }

}