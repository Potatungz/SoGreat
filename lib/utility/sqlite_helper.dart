import 'package:flutter_sogreat_application/model/my_garage_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDatabase = "sogreat.db";
  final String tableDatabase = "mygarageTABLE";
  int version = 1;

  final String idColumn = "id";
  final String idGarage = "idGarage";
  final String idCar = "idCar";
  final String modelCar = "modelCar";
  final String pathImage = "pathImage";
  final String brandImage = "brandImage";

  SQLiteHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            "CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $idGarage TEXT, $idCar TEXT, $modelCar TEXT, $pathImage TEXT, $brandImage TEXT)"),
        version: version);
  }

  Future<Null> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<Null> insertDataToSQLite(MyGarageModel myGarageModel) async {
    Database database = await connectedDatabase();

    try {
      database.insert(tableDatabase, myGarageModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('e insert Data ===> ${e.toString()}');
    }
  }

  Future<List<MyGarageModel>> readAllDataFromSQLite()async{
    Database database = await connectedDatabase();
    List<MyGarageModel> mygarageModels = List();

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      MyGarageModel myGarageModel = MyGarageModel.fromJson(map);
      mygarageModels.add(myGarageModel);
    }

    return mygarageModels;
  }

  Future<Null> deleteDataWhereId(int id)async{

    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase, where: "$idColumn = $id");
    } catch (e) {
      print("e delete ===> ${e.toString()}");
    }
  }
}
