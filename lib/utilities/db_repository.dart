import 'package:Nensi/models/info_mahasiswa_model.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class dbRepository {
  //CRUD
  //Create : Insert
  //Read
  //Update : Edit
  //Delete

  DatabaseHelper _databaseHelper = new DatabaseHelper();

  //insert data mahasiswa ke table
  Future<int> insertData(InfoMahasiswaModel model) async {
    final Database db = await _databaseHelper.initDatabase();

    final result = await db.insert(_databaseHelper.tableName, model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  //read data
  Future<List<InfoMahasiswaModel>> readData() async {
    final Database db = await _databaseHelper.initDatabase();
    //query buat manggil tabel
    final List<Map<String, dynamic>> datas =
        await db.query(_databaseHelper.tableName);

    List<InfoMahasiswaModel> result = List.generate(datas.length, (index) {
      return InfoMahasiswaModel.fromMap(datas[index]);
    });
    return result;
  }

  //update data
  Future<int> updateData(InfoMahasiswaModel model) async {
    final Database db = await _databaseHelper.initDatabase();
    final result = await db.update(_databaseHelper.tableName, model.toMap(),
        //parameter kondisi
        where: 'id =?',
        whereArgs: [model.id]);
    return result;
  }

  //Hapus data
  Future<int> deleteData(InfoMahasiswaModel model) async {
    final Database db = await _databaseHelper.initDatabase();
    final result = await db.delete(_databaseHelper.tableName,
        //parameter kondisi
        where: 'id =?',
        whereArgs: [model.id]);
    return result;
  }

//Search data
  Future<List<InfoMahasiswaModel>> searchData(String keyword) async {
    final Database db = await _databaseHelper.initDatabase();
    String rawQuery =
        'SELECT * FROM ${_databaseHelper.tableName} WHERE nama like "%$keyword%"';
    final List<Map<String, dynamic>> datas = await db.rawQuery(rawQuery);

    final result = List.generate(datas.length, (index) {
      return InfoMahasiswaModel.fromMap(datas[index]);
    });
    return result;
  }
}
