import 'package:Nensi/models/info_mahasiswa_model.dart';
import 'package:Nensi/utilities/db_repository.dart';
//import 'package:Batch_256/utilities/repositories/db_repository.dart';

class InfoMahasiswaViewmodel {
  InfoMahasiswaViewmodel();

  Future<int> insertData(InfoMahasiswaModel model) async {
    return await dbRepository().insertData(model);
  }

  Future<List<InfoMahasiswaModel>> readData() async {
    return await dbRepository().readData();
  }

  Future<int> updateData(InfoMahasiswaModel model) async {
    return await dbRepository().updateData(model);
  }

  Future<int> deleteData(InfoMahasiswaModel model) async {
    return await dbRepository().deleteData(model);
  }

  Future<List<InfoMahasiswaModel>> searchData(String keyword) async {
    return await dbRepository().searchData(keyword);
  }
}
