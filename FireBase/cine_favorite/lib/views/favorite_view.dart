<<<<<<< HEAD
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
=======
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cine_favorite/controllers/favorite_movie_controller.dart';
import 'package:cine_favorite/models/favorite_movie.dart';
import 'package:cine_favorite/views/search_movie_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});
>>>>>>> ca25cd3ef5dfcae6ee2b591b13639b5392bdcfb1

  @override
  State<HomeView> createState() => _HomeViewState();
}

<<<<<<< HEAD
class _HomeViewState extends State<HomeView> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  bool _registrando = false;
  String _status = "Aguardando registro...";
  Position? _posicaoAtual;

  // Coordenadas do local de trabalho (exemplo: escola/fábrica)
  final double localLat = -23.5505;
  final double localLon = -46.6333;

  Future<void> _registrarPonto() async {
    setState(() {
      _registrando = true;
      _status = "Verificando localização...";
    });

    try {
      // Pedir permissão de localização
      LocationPermission perm = await Geolocator.requestPermission();
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        setState(() {
          _status = "Permissão de localização negada.";
          _registrando = false;
        });
        return;
      }

      // Pegar posição atual
      Position posicao = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      double distancia = Geolocator.distanceBetween(
        localLat,
        localLon,
        posicao.latitude,
        posicao.longitude,
      );

      if (distancia <= 100) {
        await _firestore.collection("registros_ponto").add({
          "uid": _auth.currentUser!.uid,
          "email": _auth.currentUser!.email,
          "data": DateTime.now().toIso8601String(),
          "latitude": posicao.latitude,
          "longitude": posicao.longitude,
        });

        setState(() {
          _status = "Ponto registrado com sucesso!";
          _posicaoAtual = posicao;
        });
      } else {
        setState(() {
          _status =
              "Fora do raio permitido (Distância: ${distancia.toStringAsFixed(1)} m)";
        });
      }
    } catch (e) {
      setState(() {
        _status = "Erro ao registrar ponto: $e";
      });
    }

    setState(() {
      _registrando = false;
    });
  }

  Future<void> _logout() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF0E1F0E),
      appBar: AppBar(
        title: const Text("Registro de Ponto"),
        backgroundColor: Colors.green[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.access_time_rounded,
                color: Colors.greenAccent.shade400, size: 100),
            const SizedBox(height: 20),
            Text(
              "Olá, ${user?.email ?? "Usuário"}",
              style: const TextStyle(
                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              "Registre seu ponto quando estiver próximo do local de trabalho.",
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.fingerprint, size: 26),
              onPressed: _registrando ? null : _registrarPonto,
              label: Text(
                _registrando ? "Registrando..." : "Registrar Ponto",
                style: const TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 4,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              _status,
              style: TextStyle(
                color: _status.contains("✅")
                    ? Colors.greenAccent
                    : Colors.white70,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (_posicaoAtual != null)
              Text(
                "Localização: ${_posicaoAtual!.latitude.toStringAsFixed(5)}, ${_posicaoAtual!.longitude.toStringAsFixed(5)}",
                style: const TextStyle(color: Colors.white54, fontSize: 14),
                textAlign: TextAlign.center,
              ),
          ],
        ),
=======
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
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.67,
              ),
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoriteMovies[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [

                      Positioned.fill(
                        child: Image.file(
                          File(movie.posterPath),
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber.shade400, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    movie.rating.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6,
                                spreadRadius: 1,
                                offset: const Offset(2, 4),
                              ),
                            ],
                          ),
                        ),
                      ),
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
>>>>>>> ca25cd3ef5dfcae6ee2b591b13639b5392bdcfb1
      ),
    );
  }
}
