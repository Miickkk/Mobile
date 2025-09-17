import '../models/usuario_model.dart';
import '../services/api_service.dart';

class UsuarioController {

  //métodos

  //GET - All
  Future<List<UsuarioModel>> fetchAll() async{
    final list = await ApiService.getList("usuarios?_sort=nome");//ordenando pelo nome A->Z
    //retorna a Lista de Usuários (Json) Convertida para Usuario Model(DART)
    return list.map<UsuarioModel>((item)=>UsuarioModel.fromJson(item)).toList(); 
  }

  //GET - One
  Future<UsuarioModel> fetchOne(String id) async{
    final usuario = await ApiService.getOne("usuarios", id);
    return UsuarioModel.fromJson(usuario);
  }

  //POST
  Future<UsuarioModel> create(UsuarioModel u) async{
    final created = await ApiService.post("usuarios", u.toJson());
    //adicionar o usuário e retorna o usuario adicionado
    return UsuarioModel.fromJson(created);
  }

  //PUT
  Future<UsuarioModel> update(UsuarioModel u) async{
    final updated = await ApiService.put("usuarios", u.toJson(), u.id!);
    //retorna o usuário atualizado
    return UsuarioModel.fromJson(updated);
  }

  //DELETE
  Future<void> delete(String id) async{
    await ApiService.delete("usuarios", id);
    //não tem retorno
  }
}