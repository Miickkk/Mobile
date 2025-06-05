import 'package:flutter/material.dart';
import 'package:geren_colecoes/controllers/elem_controller.dart';
import 'package:geren_colecoes/view/registro_colecoes_screen.dart';
import 'package:geren_colecoes/view/visu_colecoes_screen.dart';

import '../models/colecoes_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}


class _HomeScreenState extends State<HomeScreen> {
  final ColecoesController _controllerPet = ColecoesController();
  List<Colecoes> _colecoes = [];
  bool _isLoading = true;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _carregarDados();
  }


  void _carregarDados() async {
    setState(() {
      _isLoading = true;
      _colecoes = [];
    });


    try {
      _colecoes = await _controllerColecoes.readColecoes();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao Carregar os Dados $e")));
    } finally { 
      setState(() {
        _isLoading = false;
      });
    }
  }

  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Minhas Coleções! - Cliente"),),


      body: _isLoading 
        ? Center(child: CircularProgressIndicator(),)
        : Padding(
          padding: EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: _colecoes.length,
            itemBuilder: (context,index){
              final colecoes = _colecoes[index];
              return ListTile(
                title: Text("${pet.id!} - ${pet.nome} - ${pet.raca}"),
                subtitle: Text("${pet.nomeDono} - ${pet.telefoneDono}"),
                onTap: () => Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=>DetalhePetScreen(petId: pet.id!))), //página de detalhes do PET
                onLongPress: () => _deletePet(pet.id!),
              );
            }),
          ),

          
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: 
        (context)=> CadastroPetScreen())),
        tooltip: "Adicionar Novo Pet",
        child: Icon(Icons.add),
        ),
    );
  }
  
  void _deletePet(int id) async {
    try {
      await _controllerPet.deletePet(id);
      await _controllerPet.readPets();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pet Deletado com Sucesso"))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception: $e"))
      );
      
    }
  }
}
