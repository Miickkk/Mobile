<<<<<<< HEAD
import 'package:flutter/material.dart';  // Importa widgets visuais


void main() {
  runApp(MyApp());  // Função principal que inicia o app e chama o widget MyApp
}


class MyApp extends StatelessWidget { //widget sem estado
  @override
  Widget build(BuildContext context) { 
    return MaterialApp( // Widget principal do app que define configurações gerais
      debugShowCheckedModeBanner: false,  // Remove a faixa vermelha dedebug
      home: TelaTarefas());  // Define a tela inicial como sendo a TelaTarefas
  }
}


class TelaTarefas extends StatelessWidget { // Classe da tela de tarefas (sem estado)
  final List<String> pendingTasks = [ //Tarefas pendentes
    "Limpar casa",
    "Lavar quintal",
    "Ir ao mercado",
    "Fazer um bolo",
  ];


  final List<Map<String, dynamic>> completedTasks = [ //Tarefas concluidas
    {"title": "Passar pano", "completed": true},
    {"title": "Estudar para a prova de biologia", "completed": true},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold( // Estrutura visual base do app 


      appBar: AppBar( // Barra superior (AppBar)
        title: Text(
          "IAJ Planner - Tarefas",
          style: TextStyle(fontSize: 25, color: const Color(0xFF5C75FF)),
        ),
        backgroundColor: Color.fromARGB(255, 196, 206, 255),
=======
import 'package:flutter/material.dart'; // Importa widgets visuais

void main() {
  runApp(MyApp()); // Função principal que inicia o app e chama o widget MyApp
}

class MyApp extends StatelessWidget { //widget sem estado
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Widget principal do app que define configurações gerais
      debugShowCheckedModeBanner: false, // Remove a faixa vermelha dedebug
      home: TelaTarefas(), // Define a tela inicial como sendo a TelaTarefas
    );
  }
}

class TelaTarefas extends StatelessWidget { // Classe da tela de tarefas (sem estado)
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Estrutura visual base do app 
      appBar: AppBar( // Barra superior (AppBar)
        title: Text("IAJ Planner"), 
        backgroundColor: Colors.grey[300], 
>>>>>>> a8b58fd2ddd2ecfe7765dfcf2292457b73014e41
        actions: [ // Ícones à direita da AppBar
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}), // Ícone de notificações
        ],
      ),
<<<<<<< HEAD


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
>>>>>>> a8b58fd2ddd2ecfe7765dfcf2292457b73014e41
            ),
          ],
        ),
      ),
<<<<<<< HEAD


=======
>>>>>>> a8b58fd2ddd2ecfe7765dfcf2292457b73014e41
      body: Padding( // Define um espaço ao redor do conteúdo da tela
        padding: const EdgeInsets.all(16.0), // Espaçamento de 16 em todos os lados
        child: Column( // Coluna para organizar os widgets verticalmente
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha os elementos à esquerda
<<<<<<< HEAD


=======
>>>>>>> a8b58fd2ddd2ecfe7765dfcf2292457b73014e41
          children: [
            Text(
              "Tarefas pendentes:", 
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10), // Espaço vertical de 10 pixels
<<<<<<< HEAD


            Expanded(  // Ocupa o espaço restante disponível da tela
              flex: 1,
              child: GridView.count( // Cria uma grade com número fixo de colunas
                crossAxisCount: 2, // Define 2 colunas
                childAspectRatio: 2.5,  // Define a proporção largura/altura dos containers
                mainAxisSpacing: 10,  // Espaço entre as linhas
                crossAxisSpacing: 10,  // Espaço entre as colunas


                children:
                    pendingTasks.map((task) { //Direcionamento de tarefas pendentes
                      return Container( // Caixa que representa cada tarefa
                        decoration: BoxDecoration( // Estilização da caixa
                          color: Color(0xFF5C75FF), // Cor azul personalizada
                          borderRadius: BorderRadius.circular(10),  // Bordas arredondadas
                        ),


                        child: Center( // Centraliza o conteúdo
                          child: Row( // Organiza os elementos horizontalmente
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espaça os elementos nas extremidades


                            children: [
                              Padding( // Espaçamento interno do texto
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Text(
                                  task, // Nome da tarefa
                                  style: TextStyle(color: Colors.white), // Cor branca do texto
                                ),
                              ),

                              Padding(  // Espaçamento interno do ícone
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Icon(
                                  Icons.circle_outlined,  // Ícone de círculo (vazio)
                                  color: Colors.white,  // Cor branca do ícone
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(), // Converte a lista mapeada em uma lista de widgets
              ),
            ),


            SizedBox(height: 20),
            Text(
              "Tarefas concluídas:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 1,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  return TaskItem(task: completedTasks[index]);
                },
              ),
            ),
          ],
        ),
      ),

      
      bottomNavigationBar: BottomAppBar( // Barra de navegação inferior
        color: Colors.grey[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          
          children: [
            IconButton( // Ícone clicável
              icon: Icon(Icons.check), // Ícone de "check"
              color: const Color(0xFF5C75FF),  // Cor azul personalizada
              onPressed: () => Navigator.pushNamed(context, "/tarefas"), // Vai para a rota "/tarefas"
            ),

            IconButton(
              icon: Icon(Icons.home),
              color: const Color(0xFF5C75FF),
              onPressed: () => Navigator.pushNamed(context, "/"),
            ),

            FloatingActionButton(
              onPressed: () => Navigator.pushNamed(context, "/add"),
              backgroundColor: Color(0xFF5C75FF),
              child: Icon(Icons.add),
            ),

            IconButton(
              icon: Icon(Icons.settings),
              color: const Color(0xFF5C75FF),
              onPressed: () {},
            ),

            IconButton(
              icon: Icon(Icons.dark_mode),
              color: const Color(0xFF5C75FF),
              onPressed: () {},
=======
            Expanded( // Ocupa o espaço restante disponível da tela
              child: GridView.count( // Cria uma grade com número fixo de colunas
                crossAxisCount: 2, // Define 2 colunas
                childAspectRatio: 2.5, // Define a proporção largura/altura dos containers
                mainAxisSpacing: 10, // Espaço entre as linhas
                crossAxisSpacing: 10, // Espaço entre as colunas
                children: [ // Lista com as tarefas
                  "Limpar casa",
                  "Lavar quintal",
                  "Ir ao mercado",
                  "Fazer um bolo",
                ].map((task) { // Para cada item da lista acima, cria um widget
                  return Container( // Caixa que representa cada tarefa
                    decoration: BoxDecoration( // Estilização da caixa
                      color: Color(0xFF5C75FF), // Cor azul personalizada
                      borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                    ),
                    child: Center( // Centraliza o conteúdo
                      child: Row( // Organiza os elementos horizontalmente
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espaça os elementos nas extremidades
                        children: [
                          Padding( // Espaçamento interno do texto
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              task, // Nome da tarefa
                              style: TextStyle(color: Colors.white), // Cor branca do texto
                            ),
                          ),
                          Padding( // Espaçamento interno do ícone
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.circle_outlined, // Ícone de círculo (vazio)
                              color: Colors.white, // Cor branca do ícone
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(), // Converte a lista mapeada em uma lista de widgets
              ),
            ),
            BottomNavigationBar( // Barra de navegação inferior
              items: [ // Itens da barra
                BottomNavigationBarItem(
                  icon: IconButton( // Ícone clicável
                    onPressed: () => Navigator.pushNamed(context, "/tarefas"), // Vai para a rota "/tarefas"
                    icon: Icon(
                      Icons.check, // Ícone de "check"
                      size: 30,
                      color: const Color(0xFF5C75FF), // Cor azul personalizada
                    ),
                  ),
                  label: '', // nome do botão (não vai aparecer)
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    onPressed: () => Navigator.pushNamed(context, "/"), // Vai para a tela inicial
                    icon: Icon(
                      Icons.home, // Ícone de "home"
                      size: 30,
                      color: const Color(0xFF5C75FF),
                    ),
                  ),
                  label: '', // nome do botão (não vai aparecer)
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    onPressed: () => Navigator.pushNamed(context, "/infografico"), // Vai para a tela de infográfico
                    icon: Icon(
                      Icons.add, // Ícone de "adicionar"
                      size: 30,
                      color: const Color(0xFF5C75FF),
                    ),
                  ),
                  label: '', // nome do botão (não vai aparecer)
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings, // Ícone de configurações
                    size: 30,
                    color: const Color(0xFF5C75FF),
                  ),
                  label: '', // nome do botão (não vai aparecer)
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.dark_mode, // Ícone de modo escuro
                    size: 30,
                    color: const Color(0xFF5C75FF),
                  ),
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


class TaskItem extends StatelessWidget { //Personalização dos cards de tarefas concluidas
  final Map<String, dynamic> task;

  const TaskItem({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[300],
        borderRadius: BorderRadius.circular(10),
      ),

      child: Stack(

        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                task["title"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Icon(Icons.check_circle, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
