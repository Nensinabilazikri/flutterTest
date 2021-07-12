import 'dart:io';
import 'package:Nensi/models/info_mahasiswa_model.dart';
import 'package:Nensi/views/inputdatamahasiswascreen.dart';
import 'package:Nensi/viewmodels/info_mahasiswa_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'inputdatamahasiswascreen.dart';

class ListScreen extends StatelessWidget {
  @override

  // ListScreenState createState() => ListScreenState();
  final GoogleSignInAccount akun;
  ListScreen({Key key, this.akun}) : super(key: key);
  List<InfoMahasiswaModel> _listMahasiswa = [];

  TextEditingController _keywordPencarian = new TextEditingController();
  // void initState() {
  //   super.initState();
  //   tampilkanListDataMahasiswa();
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'All to-do list',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: _keywordPencarian,
                    decoration: InputDecoration(
                        hintText: 'Search',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search_outlined),
                          onPressed: () {
                            cariDataMahasiswa();
                          },
                        )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: _listMahasiswa.length == 0
                  ? Text('0 list')
                  : ListView.builder(
                      itemCount: _listMahasiswa.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: InkWell(
                            child: Card(
                              color: index % 2 == 0
                                  ? Colors.white
                                  : Colors.blueGrey[60],
                              margin: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _listMahasiswa[index].nama,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          _listMahasiswa[index].nama,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                        );
                      }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add',
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return InputDataScreen();
          })).then((value) {
            tampilkanListDataMahasiswa();
          });
        },
      ),
    );
  }

  tampilkanListDataMahasiswa() async {
    await InfoMahasiswaViewmodel().readData().then((value) {
      print('record data : ${value.length}');
      _listMahasiswa = value;
    });
  }

  hapusDataMahasiswa(InfoMahasiswaModel data) async {
    await InfoMahasiswaViewmodel().deleteData(data).then((value) {
      print('Record terhapus : ${value}');
      tampilkanListDataMahasiswa();
    });
  }

  cariDataMahasiswa() async {
    if (_keywordPencarian.text.isEmpty) {
      tampilkanListDataMahasiswa();
    } else {
      //cari berdasarkan keyword
      await InfoMahasiswaViewmodel()
          .searchData(_keywordPencarian.text)
          .then((value) {
        print('Hasil Pencarian : ${value.length}');
        _listMahasiswa = value;
      });
    }
  }

  // @override
  // State<StatefulWidget> createState() {
  //   // TODO: implement createState
  //   throw UnimplementedError();
  // }

}

// class ListScreenState extends State<ListScreen> {
  // List<InfoMahasiswaModel> _listMahasiswa = [];

  // TextEditingController _keywordPencarian = new TextEditingController();
  // @override
  // void initState() {
  //   super.initState();
  //   tampilkanListDataMahasiswa();
  // }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(
  //         'Hi ${akun.displayName}',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //     ),
  //     body: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Center(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Text(
  //                 'All List',
  //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.all(5),
  //                 child: TextField(
  //                   controller: _keywordPencarian,
  //                   decoration: InputDecoration(
  //                       hintText: 'Search',
  //                       suffixIcon: IconButton(
  //                         icon: Icon(Icons.search_outlined),
  //                         onPressed: () {
  //                           cariDataMahasiswa();
  //                         },
  //                       )),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Expanded(
  //             child: _listMahasiswa.length == 0
  //                 ? Text('0 list')
  //                 : ListView.builder(
  //                     itemCount: _listMahasiswa.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return Container(
  //                         child: InkWell(
  //                           child: Card(
  //                             color: index % 2 == 0
  //                                 ? Colors.white
  //                                 : Colors.blueGrey[60],
  //                             margin: EdgeInsets.all(5),
  //                             child: Row(
  //                               children: [
  //                                 Padding(
  //                                   padding: EdgeInsets.all(5),
  //                                   child: Column(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.start,
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Text(
  //                                         _listMahasiswa[index].nama,
  //                                         style: TextStyle(
  //                                             fontSize: 14,
  //                                             fontWeight: FontWeight.bold),
  //                                       ),
  //                                       Text(
  //                                         _listMahasiswa[index].nama,
  //                                         style: TextStyle(
  //                                           fontSize: 14,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 )
  //                               ],
  //                             ),
  //                           ),
  //                           onTap: () {},
  //                         ),
  //                       );
  //                     }))
  //       ],
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       child: Icon(Icons.add),
  //       tooltip: 'Add',
  //       onPressed: () {
  //         Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //           return InputDataScreen();
  //         })).then((value) {
  //           setState(() {
  //             tampilkanListDataMahasiswa();
  //           });
  //         });
  //       },
  //     ),
  //   );
  // }

  // tampilkanListDataMahasiswa() async {
  //   await InfoMahasiswaViewmodel().readData().then((value) {
  //     setState(() {
  //       print('record data : ${value.length}');
  //       _listMahasiswa = value;
  //     });
  //   });
  // }

  // hapusDataMahasiswa(InfoMahasiswaModel data) async {
  //   await InfoMahasiswaViewmodel().deleteData(data).then((value) {
  //     setState(() {
  //       print('Record terhapus : ${value}');
  //       tampilkanListDataMahasiswa();
  //     });
  //   });
  // }

  // cariDataMahasiswa() async {
  //   if (_keywordPencarian.text.isEmpty) {
  //     tampilkanListDataMahasiswa();
  //   } else {
  //     //cari berdasarkan keyword
  //     await InfoMahasiswaViewmodel()
  //         .searchData(_keywordPencarian.text)
  //         .then((value) {
  //       setState(() {
  //         print('Hasil Pencarian : ${value.length}');
  //         _listMahasiswa = value;
  //       });
  //     });
  //   }
  // }
//}
