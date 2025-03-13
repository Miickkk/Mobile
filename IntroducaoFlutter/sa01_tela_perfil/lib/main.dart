import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var normal = FontWeight.normal;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perfil de Usuário'),
          backgroundColor: const Color.fromARGB(255, 182, 205, 255),
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              CircleAvatar(
                radius: 100,
                backgroundColor: const Color.fromARGB(255, 220, 231, 255),
              ),

              SizedBox(height: 20),
              Text(
                'Anick L',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text('TI', style: TextStyle(fontSize: 20, color: Colors.grey)),
              SizedBox(height: 20),

              Row(
                children: [
                  Container(
                    width: 160,
                    height: 100,
                    margin: EdgeInsets.all(20), // Margem externa de 20 pixels
                    padding: EdgeInsets.all(
                      10,
                    ), // Espaçamento interno de 10 pixels
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 182, 205, 255),
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Bordas arredondadas
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5, // Efeito de sombra
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Me',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),

                  Container(
                    width: 160,
                    height: 100,
                    margin: EdgeInsets.all(20), // Margem externa de 20 pixels
                    padding: EdgeInsets.all(
                      10,
                    ), // Espaçamento interno de 10 pixels
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 182, 205, 255),
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Bordas arredondadas
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5, // Efeito de sombra
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Place',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),

                  Container(
                    width: 160,
                    height: 100,
                    margin: EdgeInsets.all(20), // Margem externa de 20 pixels
                    padding: EdgeInsets.all(
                      10,
                    ), // Espaçamento interno de 10 pixels
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 182, 205, 255),
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Bordas arredondadas
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5, // Efeito de sombra
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'My Love',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Row(
                children: [
                  Icon(
                    Icons.tiktok,
                    size: 30,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  Text(
                    'Desenvolvedora de software com mais de 5 anos de experiência.',
                    style: TextStyle(fontSize: 18, fontWeight: normal),
                  ),
                ],
              ),

              Text(
                '----------------------------------',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 135, 172, 252),
                ),
              ),

              SizedBox(height: 10),

              Row(
                children: [
                  Icon(
                    Icons.tiktok,
                    size: 30,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  Text(
                    'Apaixonada por livros, café e tudo que envolve arte.',
                    style: TextStyle(fontSize: 18, fontWeight: normal),
                  ),
                ],
              ),

              Text(
                '----------------------------------',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 135, 172, 252),
                ),
              ),

              SizedBox(height: 10),

              Row(
                children: [
                  Icon(
                    Icons.tiktok,
                    size: 30,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  Text(
                    'Onde palavras falham, a música fala.',
                    style: TextStyle(fontSize: 18, fontWeight: normal),
                  ),
                ],
              ),

              Text(
                '----------------------------------',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 135, 172, 252),
                ),
              ),

              SizedBox(height: 10),

              Row(
                children: [
                  Icon(
                    Icons.tiktok,
                    size: 30,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  Text(
                    'Entre as sombras, a melancolia encontra sua casa.',
                    style: TextStyle(fontSize: 18, fontWeight: normal),
                  ),
                ],
              ),

              Text(
                '----------------------------------',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 135, 172, 252),
                ),
              ),

              SizedBox(height: 170),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.facebook, size: 30, color: Colors.blue),
                  SizedBox(width: 20),
                  Icon(
                    Icons.tiktok,
                    size: 30,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  SizedBox(width: 20),
                  Icon(
                    Icons.reddit,
                    size: 30,
                    color: const Color.fromARGB(255, 255, 123, 0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
