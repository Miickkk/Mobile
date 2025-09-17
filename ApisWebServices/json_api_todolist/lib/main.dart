import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(MaterialApp(home:TarefasPage()));
}

//chama a mudança de estado
class TarefasPage extends StatefulWidget {

  //garantia de importação da herança bem sucedida
  const TarefasPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TarefasPageState();    
  }
}

//faz a construção da lógica e da tela para mudança de estado
class _TarefasPageState extends State<TarefasPage>{
  //atributos
  List<Map<String,dynamic>> tarefas = []; //lista para armazenar a coleção de tarefas
  final TextEditingController _tarefaController = TextEditingController();// constrolar o textField
  String baseUrl = "http://10.109.197.12:3000/tarefas"; //endereço da API

  //métodos
  //iniciar a conexão antes de carregar a tela
  @override
  void initState() {
    super.initState();
    _carregarTarefas();
 }

 //get -> buscar informações da BD
 void _carregarTarefas() async{
  try {
    //fazer uma conexão http ( instalar a biblioteca http)
    //fazer uma solicitação get
    final response = await http.get(Uri.parse(baseUrl)); //Uri.parse -> String em URL
    if (response.statusCode == 200){
      List<dynamic> dados = json.decode(response.body);
      setState(() { //atualiza o estado da página
        //convertendo a lista Json da dados em tarefa(item) por tarefa(item)
        tarefas = dados.map((item)=> Map<String,dynamic>.from(item)).toList(); //mais dificil nunca da erro
        //tarefas = dados.cast<Map<String,dynamic>>(); // mais facil pode dar erro
        //tarefas = List<Map<String,dynamic>>.from(dados); //outra forma de fazer a conversão da lista
      });
    }
  } catch (e) {
    print("Erro ao Carregar Tarefas: $e");    
  }
 }

 //post (inserir)
 void _adicionarTarefa(String titulo) async{
  try {
    final tarefa = {"titulo":titulo, "concluida":false}; //Map->Dart
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-type": "application/json"},
      body: json.encode(tarefa)// Map/dart -> Text/json
    );
    if(response.statusCode ==201){
      _tarefaController.clear();
      _carregarTarefas();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tarefa Adicionada Com Sucesso"))
      );
    }
  } catch (e) {
    print("Erro ao inserir Tarefa: $e");
  }
 }

 //patch ou put (atualizar)
 void _atualizarTarefa(String id, bool concluida) async{
  try {
    final statusTarefa = {"concluida":!concluida};
    final response = await http.patch(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-type": "application/json"},
      body: json.encode(statusTarefa)
    );
    if(response.statusCode == 200){
      _carregarTarefas();
    }
  } catch (e) {
    print("Erro ao Atualizar Tarefa: $e");
  }
 }

 //delete
 void _removerTarefa(String id) async{
  try {
    //solicitação http -> delete (URL + ID)
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if(response.statusCode == 200){
      _carregarTarefas(); // já tem SetStatus
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Tarefa Removida Com Sucesso"),
          duration: Duration(seconds: 1),
        )
      );
    }
  } catch (e) {
    print("Erro ao Remover Tarefa $e");
  }
 }

 //build Tela
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tarefas via API"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tarefaController,
              decoration: InputDecoration(labelText: "Nova Tarefa",border: OutlineInputBorder()),
              onSubmitted: _adicionarTarefa,
            ),
            SizedBox(height: 10,),
            Expanded(
              //operador ternário
              child: tarefas.isEmpty
              ? Center(child: Text("Nenhuma Tarefa Adicionada"),)
              : ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (context,index){
                  final tarefa = tarefas[index];
                  return ListTile(//elemento do ListView
                    //leading (checkBox) -Atualizar conclusão da tarefa
                    leading: Checkbox(
                      value: tarefa["concluida"], 
                      onChanged: (value)=> _atualizarTarefa(tarefa["id"], tarefa["concluida"])),
                    title: Text(tarefa["titulo"]),
                    subtitle: Text(tarefa["concluida"] ? "Concluida": "Pendente"),
                    trailing: IconButton(
                      onPressed: () => _removerTarefa(tarefa["id"]), 
                      icon: Icon(Icons.delete)),
                  );
                })
              ),
          ],
        ),
      ),
    );
  }
}