import 'package:biblioteca_app/controllers/usuario_controller.dart';
import 'package:biblioteca_app/models/usuario_model.dart';
import 'package:biblioteca_app/views/usuarios/usuario_form_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UsuarioListView extends StatefulWidget {
  const UsuarioListView({super.key});

  @override
  State<UsuarioListView> createState() => _UsuarioListViewState();
}

class _UsuarioListViewState extends State<UsuarioListView> {
  //atributos
  final _buscarField = TextEditingController();
  List<UsuarioModel> _usuariosFiltrados = [];
  final _controller = UsuarioController(); //controller para conectar movel/view
  List<UsuarioModel> _usuarios = []; //lista par guardar os usuário
  bool _carregando = true; //bool par usar no view

  @override
  void initState() {
    // carregar os dados antes da contrução da tela
    super.initState();
    _load(); //método par carregar dados da api
  }

  _load() async {
    setState(() {
      _carregando = true;
    });
    try {
      _usuarios = await _controller
          .fetchAll(); //preenche a lista de usuário com os usuario do BD
      _usuariosFiltrados = _usuarios;
    } catch (e) {
      //caso erro mostra para o usuário
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      // modifica a variável para false - terminou de carregar
      _carregando = false;
    });
  }

  //método para filtrar usuários pelo nome e pelo email
  void _filtrar() {
    //filtar da lista já carregada
    final busca = _buscarField.text.toLowerCase();
    setState(() {
      _usuariosFiltrados = _usuarios.where((user) {
        return user.nome.toLowerCase().contains(busca) || //filta pelo nome
            user.email.toLowerCase().contains(busca); //filtra pelo email
      }).toList(); //converte em Lista
    });
  }

  //criar método deletar
  void _delete(UsuarioModel user) async {
    if (user.id == null) return; //interrompe o método
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirma Exclusão"),
        content: Text("Deseja Realmente Excluir o Usuário ${user.nome}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Ok"),
          ),
        ],
      ),
    );
    if (confirme == true) {
      try {
        await _controller.delete(user.id!);
        _load();
        //mensagem de confirmação
      } catch (e) {
        //tratar erro
      }
    }
  }

  //método para navegar para Tela User_form_view

  void _openForm({UsuarioModel? user}) async {
    //usuário entra no parametro, mas não é obrigatório
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UsuarioFormView(user: user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // operador ternário
      body: _carregando
          ? Center(
              child: CircularProgressIndicator(),
            ) // mostra uma barra circular
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _buscarField,
                    decoration: InputDecoration(labelText: "Pesquisar Usuário"),
                    onChanged: (value) => _filtrar(),
                  ),
                ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    // ,mostra a lista de usuário
                    padding: EdgeInsets.all(8),
                    itemCount: _usuariosFiltrados.length,
                    itemBuilder: (context, index) {
                      final usuario = _usuariosFiltrados[index];
                      return Card(
                        child: ListTile(
                          //leading
                          leading: IconButton(
                            onPressed: () => _openForm(user: usuario),
                            icon: Icon(Icons.edit),
                          ),
                          title: Text(usuario.nome),
                          subtitle: Text(usuario.email),
                          //trailing para deletar usuario
                          trailing: IconButton(
                            onPressed: () => _delete(usuario),
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
