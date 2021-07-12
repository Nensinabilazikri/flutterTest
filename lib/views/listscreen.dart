import 'dart:io';
import 'package:Nensi/components/costum_confirmation_dialog.dart';
import 'package:Nensi/models/info_model.dart';
import 'package:Nensi/views/inputdatascreen.dart';
import 'package:Nensi/viewmodels/info_mahasiswa_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'inputdatascreen.dart';

class ListScreen extends StatefulWidget {
  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  List<InfoMahasiswaModel> _listMahasiswa = [];

  TextEditingController _keywordPencarian = new TextEditingController();
  @override
  void initState() {
    super.initState();
    tampilkanListDataMahasiswa();
  }

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
                  'All List',
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
                                          _listMahasiswa[index].ttl,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  IconButton(
                                      icon: Icon(Icons.delete_forever),
                                      onPressed: () {
                                        //delete data
                                        var confrimDialog =
                                            CustomConfirmationDialog(
                                          title: 'Delete',
                                          message:
                                              'Are you sure delete this task? ',
                                          yes: 'Yes',
                                          no: "No",
                                          pressYes: () {
                                            //final delete
                                            InfoMahasiswaModel data =
                                                 _listMahasiswa[index];
                                            hapusData(data);

                                            Navigator.of(context).pop();
                                          },
                                          pressNo: () {
                                            Navigator.of(context).pop();
                                          },
                                        );
                                        showDialog(
                                            context: context,
                                            builder: (_) => confrimDialog);
                                      }),
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
            setState(() {
              tampilkanListDataMahasiswa();
            });
          });
        },
      ),
    );
  }

  tampilkanListDataMahasiswa() async {
    await InfoMahasiswaViewmodel().readData().then((value) {
      setState(() {
        print('record data : ${value.length}');
        _listMahasiswa = value;
      });
    });
  }

  hapusData(InfoMahasiswaModel data) async {
    await InfoMahasiswaViewmodel().deleteData(data).then((value) {
      setState(() {
        print('Record terhapus : ${value}');
        tampilkanListDataMahasiswa();
      });
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
        setState(() {
          print('Hasil Pencarian : ${value.length}');
          _listMahasiswa = value;
        });
      });
    }
  }
}
