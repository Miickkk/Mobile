import 'package:flutter/material.dart'; // Importa os widgets visuais do Flutter
<<<<<<< HEAD


class TelaInicial extends StatelessWidget { // Cria um widget sem estado
  final List<String> _imagens = [
    "assets/img/2.png",
    "assets/img/1.png",
  ]; // Lista com os caminhos das imagens

=======

class TelaInicial extends StatelessWidget { // Cria um widget sem estado 
  final List<String> _imagens = ["assets/img/2.png", "assets/img/1.png"]; // Lista com os caminhos das imagens
>>>>>>> a8b58fd2ddd2ecfe7765dfcf2292457b73014e41

  @override
  Widget build(BuildContext context) { // Método que constrói a interface da tela
    return Scaffold( // Estrutura base da tela (barra superior, corpo e rodapé)
<<<<<<< HEAD


      appBar: AppBar( // Cria a barra superior
        title: Text(
          "IAJ Planner", // Título da barra
=======
      appBar: AppBar( // Cria a barra superior
        title: Text(
          "Bem-Vindo ao IAJ PLanner!", // Título da barra
>>>>>>> a8b58fd2ddd2ecfe7765dfcf2292457b73014e41
          style: TextStyle(fontSize: 25, color: const Color(0xFF5C75FF)),
        ),
        backgroundColor: Color.fromARGB(255, 196, 206, 255),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        ],
      ),


      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 196, 206, 255),
        child: ListView(
          children: [
            TextButton(
              onPressed: () => Navigator.pushNamed(context, ""),
              child: Text(
                "Configurações",
                style: TextStyle(fontSize: 20, color: Color(0xFF5C75FF)),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, ""),
              child: Text(
                "Notificações",
                style: TextStyle(fontSize: 20, color: const Color(0xFF5C75FF)),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, "/infografico"),
              child: Text(
                "Relatório",
                style: TextStyle(fontSize: 20, color: const Color(0xFF5C75FF)),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, ""),
              child: Text(
                "Perfil",
                style: TextStyle(fontSize: 20, color: const Color(0xFF5C75FF)),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, ""),
              child: Text(
                "Ajuda",
                style: TextStyle(fontSize: 20, color: const Color(0xFF5C75FF)),
              ),
            ),
          ],
        ),
      ),

<<<<<<< HEAD
=======
      drawer: Drawer(
        child: ListView(
          children: [
            Text(
              "Configurações",
              style: TextStyle(fontSize: 25, color: Color(0xFF5C75FF)),
            ),
            Text(
              "Notificações",
              style: TextStyle(fontSize: 25, color: Color(0xFF5C75FF)),
            ),
            Text(
              "Temas",
              style: TextStyle(fontSize: 25, color: Color(0xFF5C75FF)),
            ),
            Text(
              "Perfil",
              style: TextStyle(fontSize: 25, color: Color(0xFF5C75FF)),
            ),
            Text(
              "Ajuda",
              style: TextStyle(fontSize: 25, color: Color(0xFF5C75FF)),
            ),
          ],
        ),
      ),
>>>>>>> a8b58fd2ddd2ecfe7765dfcf2292457b73014e41

      body: Center( // Centraliza o conteúdo da tela
        child: Column( // Organiza os widgets verticalmente
          children: [
            SizedBox(height: 1), // Pequeno espaçamento

<<<<<<< HEAD

            Expanded( // Ocupa o espaço restante da tela
              child: Padding( // Adiciona espaçamento interno em todos os lados
                padding: EdgeInsets.all(1),
                child: GridView.builder( // Cria uma grade dinâmica para as imagens

=======
            Expanded( // Ocupa o espaço restante da tela
              child: Padding( // Adiciona espaçamento interno em todos os lados
                padding: EdgeInsets.all(1), 
                child: GridView.builder( // Cria uma grade dinâmica para as imagens
>>>>>>> a8b58fd2ddd2ecfe7765dfcf2292457b73014e41
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // 1 item por linha
                    crossAxisSpacing: 1, // Espaçamento horizontal
                    mainAxisSpacing: 1, // Espaçamento vertical
                  ),
<<<<<<< HEAD

                  itemCount: _imagens.length, // Número de imagens
                  itemBuilder: (context, index) { // Criação de cada item
                    return Image.asset(
                      _imagens[index],
                      fit: BoxFit.cover,
                    ); // Exibe imagem da lista
=======
                  itemCount: _imagens.length, // Número de imagens
                  itemBuilder: (context, index) { // Criação de cada item
                    return Image.asset(_imagens[index], fit: BoxFit.cover); // Exibe imagem da lista
>>>>>>> a8b58fd2ddd2ecfe7765dfcf2292457b73014e41
                  },
                ),
              ),
            ),


            Text(
              "Tarefas pendentes:", // Título da seção de tarefas
<<<<<<< HEAD
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10), // Espaçamento abaixo do texto


            Expanded( // Área da lista de tarefas
              child: GridView.count(// Grade fixa de widgets
=======
              style: TextStyle(fontWeight: FontWeight.bold), 
            ),
            SizedBox(height: 10), // Espaçamento abaixo do texto

            Expanded( // Área da lista de tarefas
              child: GridView.count( // Grade fixa de widgets
>>>>>>> a8b58fd2ddd2ecfe7765dfcf2292457b73014e41
                crossAxisCount: 2, // 2 colunas
                childAspectRatio: 2.5, // Proporção largura x altura dos blocos
                mainAxisSpacing: 10, // Espaço entre linhas
                crossAxisSpacing: 10, // Espaço entre colunas
<<<<<<< HEAD

                children:
                    [
                      "Limpar casa",
                      "Lavar quintal",
                      "Ir ao mercado",
                      "Fazer um bolo",
                    ].map((task) { // Para cada tarefa, cria um container

                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF5C75FF), // cor e opacidade
                          borderRadius: BorderRadius.circular(
                            10,
                          ), // Bordas arredondadas
                        ),

                        child: Center(
                          child: Row( // Exibe texto e ícone na horizontal
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween, // Espaçamento entre texto e ícone

                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Text(
                                  task, // Nome da tarefa
                                  style: TextStyle(
                                    color: Colors.white,
                                  ), // Cor branca
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Icon(
                                  Icons
                                      .circle_outlined, // Ícone de tarefa pendente
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(), // Converte os itens em lista de widgets
              ),
            ),


            BottomAppBar( // Barra de navegação inferior
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.check),
                    color: const Color(0xFF5C75FF),
                    onPressed: () => Navigator.pushNamed(context, "/tarefas"), // Vai para a tela de tarefas
                  ),

                  IconButton(
                    icon: Icon(Icons.home),
                    color: const Color(0xFF5C75FF),
                    onPressed: () => Navigator.pushNamed(context, "/"), // Vai para a tela inicial
                  ),

                  FloatingActionButton(
                    onPressed: () => Navigator.pushNamed(context, "/add"), // Vai para a tela de adicionar tarefas
                    backgroundColor: Color(0xFF5C75FF),
                    child: Icon(Icons.add),
                  ),

                  IconButton(
                    icon: Icon(Icons.settings),
                    color: const Color(0xFF5C75FF),
                    onPressed: () {},  // Ícone sem ação ainda
                  ),

                  IconButton(
                    icon: Icon(Icons.dark_mode),
                    color: const Color(0xFF5C75FF),  // Ícone modo escuro
                    onPressed: () {},
                  ),
                ],
              ),
=======
                children: [
                  "Limpar casa",
                  "Lavar quintal",
                  "Ir ao mercado",
                  "Fazer um bolo",
                ].map((task) { // Para cada tarefa, cria um container
                  return Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF5C75FF), // Cor de fundo azul
                      borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                    ),
                    child: Center(
                      child: Row( // Exibe texto e ícone na horizontal
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espaçamento entre texto e ícone
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              task, // Nome da tarefa
                              style: TextStyle(color: Colors.white), // Cor branca
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.circle_outlined, // Ícone de tarefa pendente
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(), // Converte os itens em lista de widgets
              ),
            ),

            BottomNavigationBar( // Barra de navegação inferior
              items: [
                BottomNavigationBarItem(
                  icon: IconButton(
                    onPressed: () => Navigator.pushNamed(context, "/tarefas"), // Vai para a tela de tarefas
                    icon: Icon(Icons.check, size: 30, color: const Color(0xFF5C75FF)),
                  ),
                  label: '', // nome do botão (não vai aparecer)
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    onPressed: () => Navigator.pushNamed(context, "/"), // Vai para a tela inicial
                    icon: Icon(Icons.home, size: 30, color: const Color(0xFF5C75FF)),
                  ),
                  label: '', // nome do botão (não vai aparecer)
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    onPressed: () => Navigator.pushNamed(context, "/infografico"), // Vai para o infográfico
                    icon: Icon(Icons.add, size: 30, color: const Color(0xFF5C75FF)),
                  ),
                  label: '', // nome do botão (não vai aparecer)
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings, size: 30, color: const Color(0xFF5C75FF)), // Ícone sem ação ainda
                  label: '', // nome do botão (não vai aparecer)
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.dark_mode, size: 30, color: const Color(0xFF5C75FF)), // Ícone modo escuro (sem ação)
                  label: '', // nome do botão (não vai aparecer)
                ),
              ],
>>>>>>> a8b58fd2ddd2ecfe7765dfcf2292457b73014e41
            ),
          ],
        ),
      ),
    );
  }
}
