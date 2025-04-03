import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: TelaTarefas());
  }
}

class TelaTarefas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IAJ Planner"),
        backgroundColor: Colors.grey[300],
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Text("Configurações"),
            Text("Notificações"),
            Text("Temas"),
            Text("Perfil"),
            Text("Ajuda"),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tarefas pendentes:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children:
                    [
                      "Limpar casa",
                      "Lavar quintal",
                      "Ir ao mercado",
                      "Fazer um bolo",
                    ].map((task) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF5C75FF), // cor e opacidade
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Text(
                                  task,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Icon(
                                  Icons.circle_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: IconButton(
                    onPressed: () => Navigator.pushNamed(context, "/tarefas"),
                    icon: Icon(
                      Icons.check,
                      size: 30,
                      color: const Color(0xFF5C75FF),
                    ),
                  ),
                  label: '',
                ),

                BottomNavigationBarItem(
                  icon: IconButton(
                    onPressed: () => Navigator.pushNamed(context, "/"),
                    icon: Icon(
                      Icons.home,
                      size: 30,
                      color: const Color(0xFF5C75FF),
                    ),
                  ),
                  label: '',
                ),

                BottomNavigationBarItem(
                  icon: IconButton(
                    onPressed: () => Navigator.pushNamed(context, "/infografico"),
                    icon: Icon(
                      Icons.add,
                      size: 30,
                      color: const Color(0xFF5C75FF),
                    ),
                  ),
                  label: '',
                ),

                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 30,
                    color: const Color(0xFF5C75FF),
                  ),
                  label: '',
                ),

                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.dark_mode,
                    size: 30,
                    color: const Color(0xFF5C75FF),
                  ),
                  label: '',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
