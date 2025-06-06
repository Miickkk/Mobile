import 'package:flutter/material.dart';
import 'package:geren_colecoes/controllers/item_controller.dart';
import 'package:geren_colecoes/controllers/evento_controller.dart';
import 'package:geren_colecoes/models/colecao_model.dart';
import 'package:geren_colecoes/models/event_colecao_model.dart';
import 'package:geren_colecoes/view/detalhe_colecao_screen.dart';

class DetalheColecaoScreen extends StatefulWidget {
  final int colecaoId;

  const DetalheColecaoScreen({
    super.key,
    required this.colecaoId,
  });

  @override
  State<DetalheColecaoScreen> createState() => _DetalheColecaoScreenState();
}

class _DetalheColecaoScreenState extends State<DetalheColecaoScreen> {
  final ColecaoController _colecaoController = ColecaoController();
  final ItemController _itemController = ItemController();

  bool _isLoading = true;

  Colecao? _colecao;
  List<Item> _itens = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _colecao = await _colecaoController.readColecaoById(widget.colecaoId);
      _itens = await _itemController.readItensForColecao(widget.colecaoId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhes da Coleção")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _colecao == null
              ? Center(child: Text("Erro ao carregar a coleção."))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Título: ${_colecao!.titulo}", style: TextStyle(fontSize: 20)),
                      Text("Categoria: ${_colecao!.categoria}"),
                      Text("Descrição: ${_colecao!.descricao}"),
                      Text("Proprietário: ${_colecao!.proprietario}"),
                      Text("Valor Estimado: ${_colecao!.valorEstimado}"),
                      Text("Item Raro: ${_colecao!.itemRaro ? 'Sim' : 'Não'}"),
                      Text("Local Armazenado: ${_colecao!.localArmazenado}"),
                      Divider(),
                      Text("Itens:", style: TextStyle(fontSize: 20)),
                      _itens.isEmpty
                          ? Center(child: Text("Nenhum item cadastrado nesta coleção."))
                          : Expanded(
                              child: ListView.builder(
                                itemCount: _itens.length,
                                itemBuilder: (context, index) {
                                  final item = _itens[index];
                                  return Card(
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    child: ListTile(
                                      title: Text(item.nome),
                                      subtitle: Text(item.descricao),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _deleteItem(item.id!),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdicionarItemScreen(colecaoId: widget.colecaoId),
          ),
        ).then((_) => _carregarDados()), // recarrega ao voltar
        child: Icon(Icons.add),
      ),
    );
  }

  void _deleteItem(int itemId) async {
    try {
      await _itemController.deleteItem(itemId);
      _itens = await _itemController.readItensForColecao(widget.colecaoId);
      setState(() {}); // atualiza a tela
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Item deletado com sucesso.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao deletar item: $e")),
      );
    }
  }
}
