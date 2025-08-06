//Teste de Conversão Json <-> Dart
import 'dart:convert'; //nativa -> não precisa instalar para o pubspec

void main(){
  //tenho um texto em formato de JSON
  
  String UsuarioJson = '''{
                             "id": "1ab2",
                             "user": "usuario1",
                             "nome": "Maria L",
                             "idade": 19,
                             "cadastrado": true
                      }'''; //tres aspas voce consegue escrever quebrando linha

  // para manipular o texto
  //converter (decode) JSON -> MAP                      
  Map<String,dynamic> usuario = json.decode(UsuarioJson);

  //manipulando informações do JSON -> MAP
  print(usuario["idade"]);
  usuario["idade"] = 21;

  //converter (encode) de MAP -> JSON 
  UsuarioJson = json.encode(usuario);

  //tenho novamente um JSON em formato de Texto
  print(UsuarioJson);
}