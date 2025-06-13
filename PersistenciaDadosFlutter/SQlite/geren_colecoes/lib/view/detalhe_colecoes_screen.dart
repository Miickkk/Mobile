import 'package:flutter/material.dart';
import 'package:geren_colecoes/controllers/item_controller.dart';
import 'package:geren_colecoes/models/colecoes_model.dart';
import 'package:geren_colecoes/models/item_model.dart';
import 'package:geren_colecoes/view/adic_item_screen.dart';

class DetalheColecaoScreen extends StatefulWidget {
  final Colecao colecaoSelecionada;

  const DetalheColecaoScreen({Key? key, required this.colecaoSelecionada}) : super(key: key);

  @override
  State<DetalheColecaoScreen> createState() => _DetalheColecaoScreenState();
}

class _DetalheColecaoScreenState extends State<DetalheColecaoScreen> {
  final ItemColecaoController _itemColecaoController = ItemColecaoController();

  bool _isLoading = true;
  List<ItemColecao> _itens = [];

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
      _itens = await _itemColecaoController.readItemsByColecaoId(widget.colecaoSelecionada.id!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar dados: $e")),
      );
      _itens = [];
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteItem(int itemId) async {
    try {
      await _itemColecaoController.deleteItem(itemId);
      await _carregarDados();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Item deletado com sucesso")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao deletar item: $e")),
      );
    }
  }

  void _mostrarDetalhesItem(ItemColecao item) {
    final Color accentColor = Colors.deepPurple.shade300;
    final Color titleColor = Colors.deepPurple.shade700;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.purple.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(item.nome, style: TextStyle(color: titleColor, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfo("Descrição", item.descricao, accentColor, titleColor),
            _buildInfo("Data de aquisição", item.dataAquisicao.toString(), accentColor, titleColor),
            _buildInfo("Valor estimado", "R\$ ${item.valor.toStringAsFixed(2)}", accentColor, titleColor),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Fechar"),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(String titulo, String conteudo, Color accentColor, Color titleColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.label_important, color: accentColor, size: 18),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  conteudo,
                  style: TextStyle(fontSize: 14, color: accentColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color bgColor = Colors.purple.shade50;
    final Color cardColor = Colors.purple.shade100;
    final Color accentColor = Colors.deepPurple.shade300;
    final Color titleColor = Colors.deepPurple.shade700;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text("Detalhes da Coleção: ${widget.colecaoSelecionada.nome}"),
        backgroundColor: accentColor,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: accentColor))
          : _itens.isEmpty
              ? Center(
                  child: Text(
                    "Nenhum item cadastrado.",
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Itens",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _itens.length,
                          itemBuilder: (context, index) {
                            final item = _itens[index];
                            return Card(
                              color: cardColor,
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.collections, color: accentColor),
                                title: Text(
                                  item.nome,
                                  style: TextStyle(
                                    color: titleColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  item.descricao,
                                  style: TextStyle(color: accentColor),
                                ),
                                onTap: () => _mostrarDetalhesItem(item),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    if (item.id != null) {
                                      _deleteItem(item.id!);
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: accentColor,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdicionarItemScreen(colecao: widget.colecaoSelecionada),
            ),
          );
          if (result == true) {
            _carregarDados();
          }
        },
        child: const Icon(Icons.add),
        tooltip: "Adicionar Novo Item",
      ),
    );
  }
}