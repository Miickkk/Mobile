//classe para gerenciar o relacionamento do modelo com a interface

import 'dart:io';

import 'package:cine_favorite/models/favorite_movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FavoriteMovieController {
  //atributos
  final _auth = FirebaseAuth.instance; //conecta com Auth do Firebase
  final _db = FirebaseFirestore.instance; //conecta com o FireStore

  //Criar um User => método para buscar o usuário logado
  User? get currentUser => _auth.currentUser;

  //métodos para Favorite Movie

  //addFavorite => adiciona o filme a lista de Favoritos
  void addFavorite(Map<String,dynamic> movieData) async{
    //usar bibliotecas path e path_provider para armazenar a img no celular
    //baixar a imagem da internet
    final imagemUrl = "https://image.tmdb.org/t/p/w500${movieData["poster_path"]}";
    //https://image.tmdb.org/t/p/w500/6vbxUh6LWHGhfuPI7GrimQaXNsQ.jpg
    final responseImg = await http.get(Uri.parse(imagemUrl));
    //armazenar a imagem no dispositivo
    final imagemDir = await getApplicationDocumentsDirectory();
    final imagemFile = File("${imagemDir.path}/${movieData["id"]}.jpg");
    await imagemFile.writeAsBytes(responseImg.bodyBytes);

    //criar o OBJ no DB
    final movie = FavoriteMovie(
      id: movieData["id"], 
      title: movieData["title"], 
      posterPath: imagemFile.path.toString()); //arrumar o endereço da imagem

    //adicioanr o OBj ao FireStore
    await _db.collection("users").doc(currentUser!.uid).collection("favorite_movies")
    .doc(movie.id.toString()).set(movie.toMap());
  }
  
  //listFavorite => Pegar a Lista de Filmes no BD
  //Stream => listener, pega a lista de favoritos sempre que for modificada
  Stream<List<FavoriteMovie>> getFavoriteMovies(){
    //verifica se o usuário existe
    if(currentUser ==null) return Stream.value([]); //retrona a lista vazia caso não tenha usuário

    return _db.collection("users")
    .doc(currentUser!.uid)
    .collection("favorite_movies")
    .snapshots()
    .map((e)=> e.docs.map(
      (i)=>FavoriteMovie.fromMap(i.data())).toList());
  }

  //removeFavorite
  void removeFavoriteMovie (int movieId) async{
    if(currentUser == null) return;
    await _db.collection("users").doc(currentUser!.uid).collection("favorite_movies")
    .doc(movieId.toString()).delete();

    //deletar a imagem do diretório
    final imagemPath = await getApplicationDocumentsDirectory();
    final imagemFile = File("${imagemPath.path}/$movieId.jpg");
    try {
      await imagemFile.delete();
    } catch (e) {
      print("erro ao deletar img");
    }

  }

  //updateRating
  void updateMovieRating (int movieId, double rating) async{
    if(currentUser == null) return;
    await _db.collection("users").doc(currentUser!.uid).collection("favorite_movies")
    .doc(movieId.toString()).update({"rating":rating});
  }
}