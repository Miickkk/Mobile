import 'package:exemplo_sqlite/controllers/notas_controller.dart';
import 'package:flutter/material.dart';

import '../models/notas_model.dart';

class NotaScreen extends StatefulWidget{
  @override
  State<NotaScreen> createState() => _NotaScreenState();
}

class _NotaScreenState extends State<NotaScreen>{
  final NotasController _notasController = NotasController();

  //lista para as notas
  List<Nota> _notes = [];
  bool _isLoanding = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadNotas(); //carregar as Notas no Início
  }

  Future<void> _loadNotas() async{
    setState(() {
      _isLoanding = true;
    });
    try {
      _notes = await _notasController.fetchNotas();
    } catch (e) {
      print("Erro ao Carregar : $e");
      _notes = [];      
    } finally{
      setState(() {
        _isLoanding = false; //finaliza o estado de carregamento
      });
    }
  }

  Future<void> _addNotas() async{
    Nota novaNota = Nota(titulo: "Nota ${DateTime.now()}", conteudo: "Conteúdo da Nota");
    final id = await _notasController.addNota(novaNota);
    _loadNotas();
  }

  Future<void> _deleteNota(int id) async{
    final delete = await _notasController.deleteNota(id);
    _loadNotas();
  }

  Future<void> _updateNota(Nota nota) async{
    Nota notaAtualizada = Nota(id: nota.id, titulo: "${nota.titulo} (editado)", conteudo: nota.conteudo);
    final update = await _notasController.updateNota(notaAtualizada);
    _loadNotas();
    //showDialog
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Minhas Notas"),),
      body: _isLoanding ? Center( child: CircularProgressIndicator()) : ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context,index){
          final nota = _notes[index];
          return ListTile(
            title: Text(nota.titulo),
            subtitle: Text(nota.conteudo),
            onTap: () => _updateNota(nota),
            onLongPress: () => _deleteNota(nota.id!),
          );
        }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNotas,
        tooltip: "Adicionar Nota",
        child: Icon(Icons.add),),
        
    );
  }




}