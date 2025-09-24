//classe de modelagem de dados para Movie

class FavoriteMovie {
  //atributos
  final int id; //Id fo TMDB
  final String  title; //título do filme no TMDB
  final String posterPath; //Caminho apra imagem do Poster
  double rating; //nota que o Usuário do APP dará para o filme

  //construtor
  FavoriteMovie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.rating = 0
  });

  //métodos de conversão de OBJ <=> Json

  //toMAp obj => Json
  Map<String,dynamic> toMap() {
    return{
      "id": id,
      "title":title,
      "posterPath":posterPath,
      "rating":rating
    };
  }

  //fromMap Json => OBJ
  factory FavoriteMovie.fromMap(Map<String,dynamic> map) {
    return FavoriteMovie(
      id: map["id"], 
      title: map["title"], 
      posterPath: map["posterPath"],
      rating: (map["rating"] as num).toDouble());
  }
}