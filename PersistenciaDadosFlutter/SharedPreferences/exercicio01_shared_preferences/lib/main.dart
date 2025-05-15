//criar um tela de perfil persistente, que muda de cor ao selecionar salvar a cor
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){ //função principal. que vai fazer rodar a tela inicial
 runApp(MaterialApp( //widget raiz (principal - Elementos Visual)
  //home
  home: PerfilPage(),
  //consfigurações de rota
  // routes: ,
  //configurações de tema
 ));
}

class PerfilPage extends StatefulWidget{ //Tela Dinâmica
  //chamar o createState
  @override
  State<PerfilPage> createState()=> _PerfilPageState(); //chamar a mudança de estado da página
}

class _PerfilPageState extends State<PerfilPage>{
  //atributos
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _idadeController = TextEditingController();

  String? _nome; //permite a variavel nula inicialmente
  String? _idade;

  String? _cor;
  Color _corFundo = Colors.white; //cor inical do meu aplicativo

  Map<String,Color> coresDisponiveis={
    "Azul": const Color(0xFFACDAFF),
    "Verde": const Color(0xFFB0FFB3),
    "Vermelho": const Color(0xFFFFB5B0),
    "Amarelo": const Color(0xFFFFF174),
    "Cinza": const Color(0xFF9E9E9E),
    "Laranja": const Color(0xFFFFD78B),
    "Roxo": const Color(0xFFD1A9FF),
    "Rosa": const Color(0xFFF49FFF), 
  };


  //métodos
  @override
  void initState() {//método para carregar as informações antes de buildar a tela
    // TODO: implement initState
    super.initState();
    _carregarPreferencias();
  }

  _carregarPreferencias() async{//metodo assuincrono (método que ira conectar com uam base de dados)
    //conectar com a shared Preferences
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() { //mudança de estado
      _nome = _prefs.getString("nome");
      _idade = _prefs.getString("idade");
      _cor = _prefs.getString("cor");
      if(_cor != null){
        _corFundo = coresDisponiveis[_cor!]!; //cor não poder ser nullo
      }
    });
  }

  _salvarPreferencias() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _nome = _nomeController.text.trim();
    _idade = _idadeController.text.trim();
    _corFundo = coresDisponiveis[_cor!]!;
    await _prefs.setString("nome", _nome ?? "");
    await _prefs.setString("idade", _idade ?? "");
    await _prefs.setString("cor", _cor ?? "Branco");
    setState(() {
      
    });
  }

  @override 
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: _corFundo,
      appBar: AppBar(title: Text("Meu Perfil", 
          style: TextStyle(color: _cor=="Branco"? Colors.black : Colors.white ),),
        backgroundColor: _corFundo,),
      body: Padding(padding: EdgeInsets.all(16), child: ListView(
        children: [
          TextField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: "Nome"),
          ),
          TextField(
            controller: _idadeController,
            decoration: InputDecoration(labelText: "Idade"),
          ),
          SizedBox(height: 16,),
          DropdownButtonFormField(
            value: _cor,
            decoration: InputDecoration(labelText: "Cor Favorita"),
            items: coresDisponiveis.keys.map(
              (cor){
                return DropdownMenuItem(
                  value: cor,
                  child: Text(cor));
              }
            ).toList(), 
            onChanged: (valor){
              setState(() {
                _cor = valor;
              });
            }),
          SizedBox(height: 16,),
          ElevatedButton(onPressed: _salvarPreferencias, child: Text("Salvar Perfil")),
          SizedBox(height: 16,),
          Divider(),
          Text("Dados do Usuário:"),
          //usar um if dentro do widget
          if(_nome !=null)
            Text("Nome: $_nome",style: TextStyle(color: _cor=="Branco"? Colors.black : Colors.white )),
          if(_idade !=null)
            Text("Idade: $_idade",style: TextStyle(color: _cor=="Branco"? Colors.black : Colors.white )),
            
        ],
      ),),
    );
  }

}