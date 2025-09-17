class UsuarioModel {
  //atributos
  final String? id; //podeser nulo inicialmente
  final String nome;
  final String email;

  //construtor
  UsuarioModel({
    this.id,
    required this.nome,
    required this.email
  });

  //métodos
  //toJson
  Map<String,dynamic> toJson() => {
    "id":id,
    "nome":nome,
    "email":email
  };

  //fromJson
  factory UsuarioModel.fromJson(Map<String,dynamic> json) => UsuarioModel(
    id: json["id"].toString(),
    nome: json["nome"].toString(), 
    email: json["email"].toString());
}