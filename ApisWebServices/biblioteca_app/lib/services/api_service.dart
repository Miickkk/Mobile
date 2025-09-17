import 'dart:convert';

import 'package:http/http.dart' as http;
//classe para auxiliar nas chamadas da api

class ApiService {
  //atributos e métodos da Classe e não do Obj
  // base URL para Conexão API
  //static -> transforma o atributo em atributo da classe não do obj
  static const String _baseUrl = "http://10.109.197.10:3000";

  //métodos
  //GET (Listar todos os Recurso)
  static Future<List<dynamic>> getList(String path) async{
                                        //http://10.109.197.10:3000/livros
    final res = await http.get(Uri.parse("$_baseUrl/$path")); //uri -> convert string -> URL
    //decode -> String/Json -> Dart/Map
    if(res.statusCode == 200) return json.decode(res.body); // deu certo convert as resposta de json -> list Dynamic e final
    //se não deu certo -> gerar um erro
    throw Exception("Falha ao Carregar Lista de $path");
  }

  //GET (Listar um Unico Recurso)
  static Future<Map<String,dynamic>> getOne(String path, String id) async{
    final res = await http.get(Uri.parse("$_baseUrl/$path/$id"));
    if (res.statusCode == 200) return json.decode(res.body);
    // se não deu certo -> Criar Erro
    throw Exception("Falha ao Carregar Recurso de $path");
  }

  //POST ( Criar novo Recurso)
  static Future<Map<String,dynamic>> post(String path, Map<String,dynamic> body) async{
    final resp = await http.post(
      //endereço da api
      Uri.parse("$_baseUrl/$path"),
      //headers
      headers: {"Content-Type/":"application/json"},
      body: json.encode(body)
    );
    if(resp == 201) return json.decode(resp.body);
    //se não deu certo -> gerar erro
    throw Exception("Falha ao Criar Recurso em $path");
  }

  //PUT (Atualizar Recurso)
  static Future<Map<String,dynamic>> put(String path, Map<String,dynamic> body, String id) async{
    final res = await http.put(
      //endereço da api
      Uri.parse("$_baseUrl/$path/$id"),
      //headers
      headers: {"Content-Type/":"application/json"},
      body: json.encode(body)
    );
    if(res.statusCode == 200) return json.decode(res.body);
    //se não deu certo -> gerar erro
    throw Exception("Falha ao Alterar Recurso em $path");
  }

  //DELETE (Apagar Recurso)
  static delete(String path, String id) async{
    final res = await http.delete(Uri.parse("$_baseUrl/$path/$id"));
    //se deu certo apaga o resurso, se deu errado retorna o erro
    if ( res.statusCode != 200) throw Exception("Falha ao Deletar Recurso $path");
  }
}