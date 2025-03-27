import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();

  String _nome = "";
  String _email = "";
  double _idade = 1;
  bool _aceite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela Cadastro"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("Cadastro"),

              //campo Nome
              TextFormField(
                decoration: InputDecoration(labelText: "Digite seu Nome"),
                validator:
                    (value) =>
                        value!.isEmpty
                            ? "Campo não Preenchido!!!"
                            : null, //Operador Ternário (Condição ? True : False)
                onSaved: (value) => _nome = value!, //formulário
              ),
              SizedBox(height: 20),

              //Campo Email
              TextFormField(
                decoration: InputDecoration(labelText: "Digite seu Email"),
                validator:
                    (value) =>
                        value!.contains("@") ? null : "digite um e-mail Válido",
                onSaved: (value) => _email = value!,
              ),

              //Campo Idade
              Text("Coloque sua Idade"),
              Slider(
                value: _idade,
                min: 1,
                max: 50,
                divisions: 30,
                label: _idade.round().toString(),
                onChanged: (value) {
                  setState(() {
                    _idade = value;
                  });
                },
              ),

              //Aceite dos Termos de Uso
              CheckboxListTile(
                value: _aceite,
                title: Text("Aceito os Termos de Uso"),
                onChanged: (value) {
                  setState(() {
                    _aceite = value!;
                  });
                },
              ),

              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/"),
                child: Text("Voltar"),
              ),
              //Criar a Validação dos Dados do formulários para mudar de tela
              ElevatedButton(
                onPressed: _enviarFormulario,
                child: Text("Enviar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _enviarFormulario() {
    if (_formKey.currentState!.validate() && _aceite) {
      _formKey.currentState!.save();
      Navigator.pushNamed(context, "/confirmacao");
    }
  }
}
