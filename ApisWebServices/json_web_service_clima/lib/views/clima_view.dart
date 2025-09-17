import 'package:flutter/material.dart';
import 'package:json_web_service_clima/controllers/clima_controller.dart';
import 'package:json_web_service_clima/models/clima_model.dart';

class ClimaView extends StatefulWidget{
  const ClimaView({
    super.key
  });

  @override
  State<StatefulWidget> createState() {
    return _ClimaViewState();
  }
}

class _ClimaViewState extends State<ClimaView>{
  //atributos
  final TextEditingController _cidadeController = TextEditingController();
  ClimaModel? _clima;
  String? _erro;
  final ClimaController _climaController = ClimaController();

  //método para busca clima da cidade
  void _buscar() async{
    try {
      final cidade = _cidadeController.text.trim();
      final resultado = await _climaController.buscarClima(cidade);
      setState(() {
        if(resultado != null){
          _clima = resultado;
          _erro = null;
        } else{
          _clima = null;
          _erro = "Cidade Não Encontrada";
        }
      });
    } catch (e) {
      print("Erro ao buscar Cidade: $e");
    }
  }

  //build da Tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clima em Tempo Real"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _cidadeController,
              decoration: InputDecoration(labelText: "Digite uma Cidade"),
            ),
            ElevatedButton(onPressed: _buscar, child: Text("Buscar Clima")),
            SizedBox(height: 10,),
            Divider(),
            if(_clima != null) ...[
              Text("Cidade: ${_clima!.cidade}"),
              Text("Temperatura: ${_clima!.temperatura} °C"),
              Text("Descrição: ${_clima!.descricao}")
            ] else if(_erro != null) ...[
              Text(_erro!)
            ] else ...[
              Text("PRocure uma Cidade")
            ]
          ],
        ),
        ),
    );
  }
}