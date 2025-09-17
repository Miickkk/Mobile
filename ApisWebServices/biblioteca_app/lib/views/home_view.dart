import 'package:biblioteca_app/views/emprestimos/emprestimos_list_view.dart';
import 'package:biblioteca_app/views/livros/livros_list_view.dart';
import 'package:biblioteca_app/views/usuarios/usuario_list_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // atributos de navegação 
  int _index = 0;
  //lista de páginas de navegação
  final List<Widget> _paginas = [
    const LivrosListView(),
    const EmprestimosListView(),
    const UsuarioListView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gerenciador de Biblioteca"),),
      body: _paginas[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() {
          _index = i;
        }),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label:"Livros"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label:"Empréstimos"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label:"Usuários"),
        ]),
    );
  }
}