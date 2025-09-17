class LivroModel {
  //atributos
  final String? id;
  final String titulo;
  final String autor;
  final bool disponivel;

  //construtor
  LivroModel({
    this.id,
    required this.titulo,
    required this.autor,
    required this.disponivel
  });

  //to json
  Map<String,dynamic> toJson() =>{
    "id":id,
    "titulo":titulo,
    "autor":autor,
    "dispinivel":disponivel
  };

  //FromJson
  factory LivroModel.fromJson(Map<String, dynamic>json) => LivroModel(
    id: json["id"].toString(),
    titulo: json["titulo"].toString(), 
    autor: json["autor"].toString(), 
    disponivel: json["disponivel"] == true ? true : false);//operador ternário para corrigir a booleana
}