//classe modelos - > conectar com as entidades do BD

class Pet{
  //atributos
  final int? id; //permite ser nulo
  final String nome;
  final String raca;
  final String nomeDono;
  final String telefoneDono;

  Pet({
    this.id,
    required this.nome,
    required this.raca,
    required this.nomeDono,
    required this.telefoneDono
  });

  //métodos do conversão -> obg-> BD : BD->obj

  Map<String,dynamic> toMap(){
    return{
      "id": id,
      "nome":nome,
      "raca":raca,
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