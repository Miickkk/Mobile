import 'package:flutter/material.dart';
import 'package:geren_colecoes/controllers/item_controller.dart';
import 'package:geren_colecoes/view/cadastro_colecao_screen.dart';
import 'package:geren_colecoes/view/detalhe_colecao_screen.dart';
import '../models/colecao_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  } 
}

class _HomeScreenState extends State<HomeScreen> {
  final ColecaoController _controllerColecao = ColecaoController();
  List<Colecao> _colecoes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _colecoes = await _controllerColecao.readColecoes();
    } catch (e) {
      ScaffoldMessenger.of(
        context
      ).showSnackBar(SnackBar(content: Text("Erro ao carregar os dados: $e")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Minhas Coleções")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: _colecoes.length,
                itemBuilder: (context, index) {
                  final colecao = _colecoes[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text("${colecao.titulo} - ${colecao.categoria}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Proprietário: ${colecao.proprietario}"),
                          Text("Valor Estimado: ${colecao.valorEstimado}"),
                          Text("Local: ${colecao.localArmazenado}"),
                          Text("Raro: ${colecao.itemRaro ? 'Sim' : 'Não'}"),
                        ],
                      ),
                      isThreeLine: true,
                      onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>DetalheColecaoScreen(colecaoId: colecao.id!))),
                      onLongPress: () => _deleteColecao(colecao.id!),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: 
        (context) => CadastroColecaoScreen())),
        tooltip: "Adicionar Nova Coleção",
        child: Icon(Icons.add),
      ),
    );
  }


  void _deleteColecao(int id) async {
    try {
      await _controllerColecao.deleteColecao(id);
      await _controllerColecao.readColecoes();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Coleção deletada com sucesso")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao deletar: $e")),
      );
    }
  }
}
