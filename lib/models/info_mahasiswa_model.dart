class InfoMahasiswaModel {
  int id;
  String nama;
  String ttl;
  String alamat;

  InfoMahasiswaModel({this.id, this.nama, this.ttl, this.alamat});
  //setter
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['nama'] = nama;
    data['ttl'] = ttl;
    data['alamat'] = alamat;
    return data;
  }

  //getter
  InfoMahasiswaModel.fromMap(Map<String, dynamic> data) {
    this.id = data['id'];
    this.nama = data['nama'];
    this.ttl = data['ttl'];
    this.alamat = data['alamat'];
  }
}
