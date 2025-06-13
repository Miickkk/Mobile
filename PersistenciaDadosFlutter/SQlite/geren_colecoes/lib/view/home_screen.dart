import 'package:flutter/material.dart';
import 'package:geren_colecoes/controllers/colecoes_controller.dart';
import 'package:geren_colecoes/view/adic_item_screen.dart';
import 'package:geren_colecoes/view/cadastro_colecoes_screen.dart';
import 'package:geren_colecoes/view/detalhe_colecoes_screen.dart';
import '../models/colecoes_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ColecoesController _colecaoController = ColecoesController();
  List<Colecao> _colecoes = [];
  bool _isLoading = true;

  Colecao? _colecaoSelecionada;

  // Ícone temático para cada tipo de coleção
  IconData _iconePorTipo(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'hq':
      case 'hqs':
        return Icons.menu_book_rounded;
      case 'moeda':
      case 'moedas':
        return Icons.monetization_on_rounded;
      case 'selo':
      case 'selos':
        return Icons.local_post_office_rounded;
      case 'outros':
        return Icons.star_border_rounded;
      default:
        return Icons.collections_bookmark_rounded;
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() => _isLoading = true);

    try {
      _colecoes = await _colecaoController.readAllColecoes();
      _colecaoSelecionada = _colecoes.isNotEmpty ? _colecoes[0] : null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar os dados: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteColecao(int id) async {
    try {
      await _colecaoController.deleteColecao(id);
      await _carregarDados();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Coleção deletada com sucesso")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao deletar: $e")),
      );
    }
  }

  void _abrirCadastroItem() {
    if (_colecaoSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecione uma coleção para cadastrar item.")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdicionarItemScreen(colecao: _colecaoSelecionada!),
      ),
    ).then((result) {
      if (result == true) {
        _carregarDados();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Item cadastrado com sucesso!")),
        );
      }
    });
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
        title: const Text("Minhas Coleções"),
        backgroundColor: accentColor,
        elevation: 0,
      ),
      drawer: Drawer(
        backgroundColor: bgColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade200, Colors.purple.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, shadows: [
                  Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(1, 2))
                ]),
              ),
            ),
            ListTile(
              leading: Icon(Icons.library_add, color: accentColor),
              title: Text('Cadastrar Coleção', style: TextStyle(color: accentColor)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastroColecaoScreen()),
                ).then((result) {
                  if (result == true) {
                    _carregarDados();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Coleção cadastrada com sucesso!")),
                    );
                  }
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.add_box, color: accentColor),
              title: Text('Cadastrar Item na Coleção', style: TextStyle(color: accentColor)),
              subtitle: _colecaoSelecionada == null
                  ? Text('Nenhuma coleção selecionada')
                  : Text('Coleção: ${_colecaoSelecionada!.nome}'),
              onTap: () {
                Navigator.pop(context);
                _abrirCadastroItem();
              },
            ),
            ListTile(
              leading: Icon(Icons.home, color: accentColor),
              title: Text('Voltar à Página Inicial', style: TextStyle(color: accentColor)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Você já está na página inicial.")),
                );
              },
            ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: accentColor))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: _colecoes.isEmpty
                  ? Center(
                      child: Text(
                        "Nenhuma coleção disponível.",
                        style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          margin: const EdgeInsets.only(bottom: 16),
                          child: DropdownButton<Colecao>(
                            hint: Text('Selecione uma coleção', style: TextStyle(color: accentColor)),
                            isExpanded: true,
                            value: _colecaoSelecionada,
                            dropdownColor: Colors.purple.shade50,
                            style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
                            underline: SizedBox(),
                            items: _colecoes
                                .map((c) => DropdownMenuItem(
                                      value: c,
                                      child: Row(
                                        children: [
                                          Icon(_iconePorTipo(c.tipoItem), color: accentColor),
                                          const SizedBox(width: 8),
                                          Text(c.nome, style: TextStyle(color: accentColor)),
                                        ],
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _colecaoSelecionada = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _colecoes.length,
                            itemBuilder: (context, index) {
                              final colecao = _colecoes[index];
                              return Card(
                                elevation: 2,
                                color: cardColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.deepPurple.shade100,
                                    child: Icon(
                                      _iconePorTipo(colecao.tipoItem),
                                      color: accentColor,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  title: Text(
                                    colecao.nome,
                                    style: TextStyle(
                                      color: titleColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
                                      Text(
                                        "Descrição: ${colecao.descricao}",
                                        style: TextStyle(color: accentColor),
                                      ),
                                      Text(
                                        "Tipo: ${colecao.tipoItem}",
                                        style: TextStyle(color: accentColor),
                                      ),
                                    ],
                                  ),
                                  isThreeLine: true,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetalheColecaoScreen(colecaoSelecionada: colecao),
                                      ),
                                    ).then((value) => _carregarDados());
                                  },
                                  onLongPress: () => _deleteColecao(colecao.id!),
                                  trailing: Icon(Icons.arrow_forward_ios, color: accentColor),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }
}