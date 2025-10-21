class Ponto {
  //atributos básicos
  final String id;          
  final String uid;         
  final String email;       
  final DateTime data;      
  final double latitude;    
  final double longitude;   
  final String tipo;        
  final String status;      
  final String? observacao; 
  final double? distancia;  

  //construtor
  Ponto({
    required this.id,
    required this.uid,
    required this.email,
    required this.data,
    required this.latitude,
    required this.longitude,
    this.tipo = "entrada",
    this.status = "registrado",
    this.observacao,
    this.distancia,
  });

  //toMap obj => Json
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "uid": uid,
      "email": email,
      "data": data.toIso8601String(),
      "latitude": latitude,
      "longitude": longitude,
      "tipo": tipo,
      "status": status,
      "observacao": observacao,
      "distancia": distancia,
    };
  }

  //fromMap Json => OBJ
  factory Ponto.fromMap(Map<String, dynamic> map) {
    return Ponto(
      id: map["id"],
      uid: map["uid"],
      email: map["email"],
      data: DateTime.parse(map["data"]),
      latitude: (map["latitude"] as num).toDouble(),
      longitude: (map["longitude"] as num).toDouble(),
      tipo: map["tipo"] ?? "entrada",
      status: map["status"] ?? "registrado",
      observacao: map["observacao"],
      distancia: map["distancia"] != null ? (map["distancia"] as num).toDouble() : null,
    );
  }
}
