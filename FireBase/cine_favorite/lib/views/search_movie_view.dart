import 'package:cine_favorite/controllers/favorite_movie_controller.dart';
import 'package:cine_favorite/services/tmdb_service.dart';
import 'package:flutter/material.dart';

class SearchMovieView extends StatefulWidget {
  const SearchMovieView({super.key});

  @override
  State<SearchMovieView> createState() => _SearchMovieViewState();
}

class _SearchMovieViewState extends State<SearchMovieView> {
  final _favMovieController = FavoriteMovieController();
  final _searchField = TextEditingController();

  List<Map<String, dynamic>> _movies = [];
  bool _isLoading = false;

  void _searchMovies() async {
    final termo = _searchField.text.trim();
    if (termo.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await TmdbService.searchMovie(termo);
      setState(() {
        _movies = result;
      });
    } catch (e) {
      setState(() {
        _movies = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.deepPurple.shade300,
          content: Text("Erro ao buscar filmes: $e"),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color roxoPrincipal = Colors.deepPurple;
    final Color roxoClaro = Colors.deepPurpleAccent;

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text(
          "Buscar Filmes",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: roxoPrincipal,
        elevation: 4,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _searchField,
              cursorColor: roxoPrincipal,
              style: TextStyle(
                color: roxoPrincipal,
                fontWeight: FontWeight.w600,
              ),

              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.6),
                labelText: "Nome do Filme",
                labelStyle: TextStyle(color: roxoClaro),
                floatingLabelStyle: TextStyle(color: roxoPrincipal),
                prefixIcon: Icon(Icons.movie_outlined, color: roxoPrincipal),
                suffixIcon: IconButton(
                  onPressed: _searchMovies,
                  icon: Icon(Icons.search, color: roxoPrincipal),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: roxoPrincipal, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: roxoClaro, width: 1.5),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 16),

            _isLoading
                ? Center(child: CircularProgressIndicator(color: roxoPrincipal))
                : _movies.isEmpty
                ? Text(
                    "Nenhum Filme Encontrado",
                    style: TextStyle(
                      color: roxoPrincipal,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _movies.length,
                      itemBuilder: (context, index) {
                        final movie = _movies[index];
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),

                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: movie["poster_path"] != null
                                ? Image.network(
                                    "https://image.tmdb.org/t/p/w500${movie["poster_path"]}",
                                    height: 50,
                                  )
                                : Icon(Icons.movie, color: roxoPrincipal),
                            title: Text(movie["title"]),
                            subtitle: Text(movie["release_date"] ?? ""),
                            trailing: IconButton(
                              onPressed: () async {
                                _favMovieController.addFavorite(movie);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: roxoPrincipal,
                                    content: Text(
                                      "${movie["title"]} adicionado com sucesso",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                                Navigator.pop(context); // volta para favoritos
                              },

                              icon: Icon(Icons.add, color: roxoPrincipal),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
