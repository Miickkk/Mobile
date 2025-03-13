import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> imagens = [
        "https://images.unsplash.com/photo-1741118235487-4912f2edee79",
        "https://images.unsplash.com/photo-1741118235487-4912f2edee79",
        "https://images.unsplash.com/photo-1504384308090-c894fdcc538d",
        "https://images.unsplash.com/photo-1518837695005-2083093ee35b",
        "https://images.unsplash.com/photo-1512486130939-2c4f79935e43",
        "https://images.unsplash.com/photo-1535279020651-a57c6d4e2021",
        "https://images.unsplash.com/photo-1533090368676-1fd25485dbba",
        "https://images.unsplash.com/photo-1506619216599-9d16d0903dfd",
        "https://images.unsplash.com/photo-1494172961521-33799ddd43a5",
        "https://images.unsplash.com/photo-1517245386807-bb43f82c33c4",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Galeria de Imagens")),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: CarouselSlider(
          options: CarouselOptions(height: 300, autoPlay: true),
          items: imagens.map((url) {
            return Container(
              margin: EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(url, fit: BoxFit.cover, width: 1000),
              ),
            );
          }).toList(),
        );
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: imagens.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _mostrarImagem(context, imagens[index]),
                child: Image.network(imagens[index], fit: BoxFit.cover),
              );
            },
          ),
        ),
      ),
    );
  } 
  void _mostrarImagem(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Image.network(url),
      ),
    );
  }
}
