import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  final List<String> _imagens = ["assets/img/2.png", "assets/img/1.png"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bem-Vindo ao IAJ PLanner!",
          style: TextStyle(fontSize: 25, color: const Color(0xFF5C75FF)),
        ),
      ),

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 1),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(1),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemCount: _imagens.length,
                  itemBuilder: (context, index) {
                    return Image.asset(_imagens[index], fit: BoxFit.cover);
                  },
                ),
              ),
            ),

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
                   icon:Icon(
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
