import 'dart:io';

import 'package:cine_favorite/controllers/favorite_movie_controller.dart';
import 'package:cine_favorite/models/favorite_movie.dart';
import 'package:cine_favorite/views/search_movie_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final _favMovieController = FavoriteMovieController();

  @override
  Widget build(BuildContext context) {
    final Color roxoPrincipal = Colors.deepPurple;
    final Color roxoClaro = Colors.deepPurpleAccent;

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text(
          "Meus Filmes Favoritos",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: roxoPrincipal,
        elevation: 4,
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: "Sair",
          ),
        ],
      ),

      body: StreamBuilder<List<FavoriteMovie>>(
        stream: _favMovieController.getFavoriteMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erro ao carregar a lista de favoritos",
                style: TextStyle(
                  color: roxoPrincipal,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: roxoPrincipal),
            );
          }

          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Nenhum filme adicionado aos favoritos",
                style: TextStyle(
                  color: roxoPrincipal,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }

          final favoriteMovies = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoriteMovies[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: Image.file(
                            File(movie.posterPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          movie.title,
                          style: TextStyle(
                            color: roxoPrincipal,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Nota: ${movie.rating}",
                          style: TextStyle(color: roxoClaro),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: roxoPrincipal,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchMovieView()),
        ),
        child: const Icon(Icons.search, color: Colors.white),
        tooltip: "Buscar Filmes",
      ),
    );
  }
}
