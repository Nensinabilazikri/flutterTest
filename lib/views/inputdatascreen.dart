import 'dart:io';
import 'package:Nensi/components/custom_snackbar.dart';
import 'package:Nensi/models/info_model.dart';
import 'package:Nensi/viewmodels/info_mahasiswa_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'listscreen.dart';

class InputDataScreen extends StatefulWidget {
  @override
  InputDataScreenState createState() => InputDataScreenState();
}

class InputDataScreenState extends State<StatefulWidget> {
  DateTime tanggalTerpilih = DateTime.now();
  String time = '';
  var tanggal = TextEditingController();
  TextEditingController _nama = new TextEditingController();
  // TextEditingController _ttl = new TextEditingController();
  TextEditingController _alamat = new TextEditingController();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String _ttl = '';
  String _jam = '';

//lokasi
  String _latitude, _longitude, _altitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input ToDo'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                maxLength: 50,
                decoration: InputDecoration(hintText: 'Task Name'),
                controller: _nama,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Time"),
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.calendar_today_sharp),
                          onPressed: () {
                            pilihTanggal();
                          }),
                      Text(
                        '$_ttl $time',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Latitude : $_latitude',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Longitude : $_longitude',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 50,
                ),
                TextButton(
                  onPressed: () {
                    tampilkanLokasiSaya();
                  },
                  child: Text('Get my current location'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.grey.withOpacity(0.3))),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                maxLength: 200,
                decoration: InputDecoration(hintText: 'Task'),
                controller: _alamat,
              ),
            ),
            Expanded(child: SizedBox()),
            FloatingActionButton(
              onPressed: () {
                simpanData();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void tampilkanLokasiSaya() {
    temukanLokasiSaya().then((value) {
      String latitude = value.latitude.toString();
      String longitude = value.longitude.toString();
      String altitude = value.altitude.toString();

      setState(() {
        _latitude = latitude;
        _longitude = longitude;
        _altitude = altitude;
      });
    });
  }

  Future<Position> temukanLokasiSaya() async {
    bool serviesEnable;
    LocationPermission permission;

    //test jika gpsnya enable
    serviesEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviesEnable) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar('Location Service Disable'));
      return Future.error('Location Service Disable');
    }
    //test jika permission sudah di berikan/belum
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar('Location Permission denied'));
      return Future.error('Location Service Disable');
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar('Location Permission permanently denied'));
      return Future.error('Location Service permanently Disable');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void simpanData() async {
    InfoMahasiswaModel model = new InfoMahasiswaModel(
      nama: _nama.text,
      ttl: _ttl,
      alamat: _latitude,
    );
    await InfoMahasiswaViewmodel().insertData(model).then((value) {
      print('respon database : $value');
      clearAllInput();
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return ListScreen();
      }));
    });
  }

  void clearAllInput() {
    setState(() {
      _nama.text = '';
      _ttl = '';
      _alamat.text = '';
    });
  }

  void pilihTanggal() async {
    final DateTime picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2023));

    if (picker != null) {
      setState(() {
        tanggalTerpilih = picker;

        //konversi dari DateTime menjadi String yg di inginkan
        _ttl = DateFormat('dd-MMM-yyyy').format(tanggalTerpilih);
      });
    }

    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
        print(selectedTime);
        time = selectedTime.toString();
        //print(time);
        time = time.substring(10, 15);
        //print(time);
        tanggal.text = tanggal.text + " " + time;
      });
  }
}
