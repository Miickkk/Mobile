import 'package:flutter/material.dart'; // Importa o pacote de Material Design do Flutter.


void main() {
  runApp(MyApp()); // Executa o aplicativo chamando a classe MyApp.
}


// Classe principal do aplicativo.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Remove o banner de modo de depuração.
      home:
          TelaInfografico(), // Define a tela inicial do aplicativo como ReportScreen.
    );
  }
}


// Classe que representa a tela de relatórios.
class TelaInfografico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Relatórios",
          style: TextStyle(fontSize: 25, color: const Color(0xFF5C75FF)),
        ), // Título da barra de aplicativo.
         backgroundColor: Color.fromARGB(255, 196, 206, 255), // Cor de fundo da AppBar.
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


      body: Padding(
        // Adiciona espaço ao redor do corpo.
        padding: const EdgeInsets.all(16.0), // Define a margem de 16 pixels.
        child: Column(
          // Layout vertical.
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinha os itens à esquerda.


          children: [
            Text(
              "Relatórios Gerais",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ), // Título dos relatórios.
            
            SizedBox(height: 20), // Espaço vertical de 20 pixels.


            Expanded(
              // Expande o widget para preencher o espaço disponível.
              child: GridView.count(
                // Cria uma grade com contagem fixa de colunas.
                crossAxisCount: 2, // Número de colunas na grade.
                crossAxisSpacing: 10, // Espaçamento entre colunas.
                mainAxisSpacing: 10, // Espaçamento entre linhas.


                children: [
                  _buildReportBox(
                    Icons.assignment,
                    "Tarefas Pendentes",
                    "Total de 8 tarefas pendentes",
                  ), // Box de tarefas pendentes.

                  _buildReportBox(
                    Icons.check_circle,
                    "Tarefas Concluídas",
                    "Total de 12 tarefas concluídas",
                  ), // Box de tarefas concluídas.

                  _buildReportBox(
                    Icons.calendar_today,
                    "Atividades do Mês",
                    "24 atividades registradas neste mês",
                  ), // Box de atividades do mês.

                  _buildReportBox(
                    Icons.warning,
                    "Atrasos",
                    "3 tarefas estão atrasadas",
                  ), // Box de atrasos.
                ],
              ),
            ),
          ],
        ),
      ),


      bottomNavigationBar: BottomAppBar(
        // Barra de navegação na parte inferior.
        color: Colors.grey[300], // Cor de fundo da BottomAppBar.
        child: Row(
          // Layout horizontal.
          mainAxisAlignment:
              MainAxisAlignment
                  .spaceAround, // Distribui os itens uniformemente.


          children: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () => Navigator.pushNamed(context, "/tarefas"),
              color: const Color(0xFF5C75FF),
            ), // Botão de verificação (sem ação).

            IconButton(
              icon: Icon(Icons.home),
              onPressed: () => Navigator.pushNamed(context, "/"),
              color: const Color(0xFF5C75FF),
            ), // Botão de home (sem ação).

            FloatingActionButton(
              // Botão flutuante para adicionar.
              onPressed: () => Navigator.pushNamed(context, "/add"),
              backgroundColor: Color(
                0xFF5C75FF,
              ), // Cor de fundo do botão flutuante.
              child: Icon(Icons.add), // Ícone de adicionar.
            ),

            IconButton(
              icon: Icon(Icons.settings),
              color: const Color(0xFF5C75FF),
              onPressed: () {},
            ), // Botão de configurações (sem ação).

            IconButton(
              icon: Icon(Icons.dark_mode),
              color: const Color(0xFF5C75FF),
              onPressed: () {},
            ), // Botão de modo claro (sem ação).
          ],
        ),
      ),
    );
  }


  // Função que cria um bloco de relatório no grid.
  Widget _buildReportBox(IconData icon, String title, String subtitle) {
    return Container(
      padding: EdgeInsets.all(16), // Preenchimento interno de 16 pixels.
      decoration: BoxDecoration(
        // Decoração do container.

        color: Colors.white, // Cor de fundo do container.
        borderRadius: BorderRadius.circular(10), // Cantos arredondados.
        boxShadow: [
          // Sombra do box.

          BoxShadow(
            color: Colors.grey, // Cor da sombra.
            spreadRadius: 2, // Espalhamento da sombra.
            blurRadius: 5, // Difusão da sombra.
          ),
        ],
      ),


      child: Column(
        // Layout vertical dentro do container.
        mainAxisAlignment: MainAxisAlignment.center, // Alinha ao centro.

        children: [
          Icon(icon, size: 40, color: Color(0xFF5C75FF)), // Ícone do relatório.
          SizedBox(height: 10), // Espaço entre o ícone e o título.
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ), // Título do relatório.

          SizedBox(height: 5), // Espaço entre o título e o subtítulo.
          Text(
            subtitle,
            textAlign: TextAlign.center,
          ), // Subtítulo do relatório.
        ],
      ),
    );
  }
}
