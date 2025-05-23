//classe de ajdua para conexão com db

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/pet_model.dart';

class PetShopDBHelper {
  // fazer conexão singleton
  static Database? _database; // obj SQlite conexão com BD
  static final PetShopDBHelper _instance = PetShopDBHelper._internal();

  PetShopDBHelper._internal();
  factory PetShopDBHelper() {
    return _instance;
  }

  //verificação do banco de dados  -> verificar se já fooi criado, e se esta aberto
  Future<DataBase> _initDatabase() async {
    final dbPath = await getDatabasePath();
    final path = join(dbPath, "petshop.db");

    return await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
          """CREATE TABLE IF NOT EXISTS pets(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          raca TEXT NOT NULL,
          nome_dono TEXT NOT NULL,
          telefone_dono TEXT NOT NULL);""", //CONTINUAÇÃO PARA CRIAÇÃOD TABELA CONSULTA
        );
      },
      version: 1,
    );
  }

  //veririfa se o banco já foi iniciado, caso contrário inicia a conexão
  Future<DataBase> get database async{
    if(_database !=null){
      return _database!;
    }else{
      _database = await _initDatabase();
      return _database!;
    }
  }

  // métodos do CRUD - PETS
  Future<int> insertPet(Pet pet) async {
    final db = await database; //verifica a conexão
    return db.insert("pets",pet.toMap()); //inserir o dado no banco
  }

  Future<List<Pet>> getPets() async{
    final db = await database; //verifica a conexão
    final List<Map<String,dynamic>> maps = await db.query("pets"); //pegar os dados do banco
    return maps.map((e) => Pet.fromMap(e)).toList(); //factory do BD -> obj
  }

  Future<Pet?> getPetById(int id) async{
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query(
      "pets", 
      where: "id=?",
      whereArgs: [id]);
    if(maps.isEmpty){
      return null;
    }else{
      Pet.fromMap(maps.first);
    }
  }

  Future<int> deletePet(int id) async{
    final db = await database;
    return await db.delete("pets", where: "id=?", whereArgs: [id]);
  } //DELETE  ON CASCADE  na tabela Consulta



}
