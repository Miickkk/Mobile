//classe de ajdua para conexão com db

import 'package:sa_petshop/models/consulta_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/pet_model.dart';

class PetShopDBHelper {
  // fazer conexão singleton
  static Database? _database; // obj SQlite conexão com BD

  //classe do tipo Singleton
  static final PetShopDBHelper _instance = PetShopDBHelper._internal();

  PetShopDBHelper._internal();
  factory PetShopDBHelper() {
    return _instance;
  }

  //verificação do banco de dados  -> verificar se já fooi criado, e se esta aberto
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "petshop.db");

    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  // método para cria as tabelas
  _onCreateDB(Database db, int version) async {
    // Cria a tabela 'pets'
    await db.execute('''CREATE TABLE IF NOT EXISTS pets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        raca TEXTNOT NULL,
        nome_dono TEXT NOT NULL,
        telefone_dono TEXT NOT NULL)''');
    print("banco pets criado");

    // Cria a tabela 'consultas'
    await db.execute('''CREATE TABLE IF NOT EXISTS consultas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pet_id INTEGER NOT NULL,
        data_hora TEXT NOT NULL, 
        tipo_servico TEXT NOT NULL,
        observacao TEXT NOT NULL,
        FOREIGN KEY (pet_id) REFERENCES 
        pets(id) ON DELETE CASCADE)''');
    print("banco consultas criado");
  }

  //veririfa se o banco já foi iniciado, caso contrário inicia a conexão
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  // métodos do CRUD - PETS
  Future<int> insertPet(Pet pet) async {
    final db = await database; //verifica a conexão
    return db.insert("pets", pet.toMap()); //inserir o dado no banco
  }

  Future<List<Pet>> getPets() async {
    final db = await database; //verifica a conexão
    final List<Map<String, dynamic>> maps = await db.query(
      "pets",
    ); //pegar os dados do banco
    return maps.map((e) => Pet.fromMap(e)).toList(); //factory do BD -> obj
  }

  Future<Pet?> getPetById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "pets",
      where: "id=?",
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      return null;
    } else {
      return Pet.fromMap(maps.first);
    }
  }

  Future<int> deletePet(int id) async {
    final db = await database;
    return await db.delete("pets", where: "id=?", whereArgs: [id]);
  } //DELETE  ON CASCADE  na tabela Consulta

  //CRUD e CRIAR o Banco de Dados das Consultas

  Future<int> insertConsulta(Consulta consulta) async {
    final db = await database;
    return await db.insert(
      "consultas",
      consulta.toMap(),
    ); //insere a consulta no BD
  }

  Future<List<Consulta>> getConsultasForPet(int petId) async {
    final db = await database;
    //consluta por PEt especifico
    List<Map<String, dynamic>> maps = await db.query(
      "consultas",
      where: "pet_id =?",
      whereArgs: [petId],
      orderBy: "data_hora ASC",
    );
    //converter a map para obj
    return maps.map((e) => Consulta.fromMap(e)).toList();
    //toList() -> forma abreviada de escrever um laço de repetição (forEach)
  }

  Future<int> deleteConsulta(int id) async {
    final db = await database;
    return db.delete("consultas", where: "id=?", whereArgs: [id]);
    // delete from table consultas where id = ? ,
  }
}
