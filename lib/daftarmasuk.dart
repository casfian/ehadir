import 'package:ehadir/statusselepasdaftarmasuk.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:location/location.dart';
import 'package:intl/intl.dart';

class Daftarmasuk extends StatefulWidget {
  const Daftarmasuk({super.key});

  @override
  State<Daftarmasuk> createState() => _DaftarmasukState();
}

class _DaftarmasukState extends State<Daftarmasuk> {
  //declare
  String? xNama;
  String? xLong;
  String? xLat;
  String? alamat;
  String? city;
  String? xTarikh;

  //tarikh dan Masa
  String tarikh = DateFormat("EEEEE, dd, yyyy").format(DateTime.now());
  String masa = DateFormat("HH:mm:ss").format(DateTime.now());

  //dropdown
  String selectedValue = "Sila Pilih";

  List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(value: "Sila Pilih", child: Text("Sila Pilih")),
    DropdownMenuItem(value: "Hadir Bertugas Pejabat", child: Text("Hadir Bertugas Pejabat")),
    DropdownMenuItem(value: "Bekerja di Rumah", child: Text("Bekerja di Rumah")),
    DropdownMenuItem(value: "Bekerja di Rumah, Kuarantin Kendiri", child: Text("Bekerja di Rumah, Kuarantin Kendiri")),
    DropdownMenuItem(value: "Kerja Luar/Kursus", child: Text("Kerja Luar/Kursus")),
    DropdownMenuItem(value: "Lain Lain", child: Text("Lain Lain")),
  ];
  return menuItems;
}

  //untuk get Lokasi
  late bool _serviceEnabled;

  late PermissionStatus _permissionGranted;

  LocationData? _userLocation;

  Future<void> _getUserLocation() async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final _locationData = await location.getLocation();

    setState(() {
      _userLocation = _locationData;

      debugPrint(_userLocation?.longitude.toString());
      debugPrint(_userLocation?.latitude.toString());

      //guna function ConvertLokasi sini
      //kenapa ada 2 ! sebab nak check null 2x
      convertLokasi(_userLocation!.latitude!, _userLocation!.longitude!);
    });
  }
  //----end get lokasi

  //function tukar coordinate ke Address
  Future<void> convertLokasi(double latConvert, double longConvert) async {
    GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: latConvert,
        longitude: longConvert,
        googleMapApiKey:
            "AIzaSyCiw-Mixse9wd1EgalpmzL29dg0L9pOOkg"); //Key get from Google Map

    print(data.latitude);
    print(data.longitude);
    print(data.address);
    print(data.city);
    print(data.state);
    print(data.postalCode);

    setState(() {
      xLat = data.latitude.toString();
      xLong = data.latitude.toString();
      alamat = data.address.toString();
      city = data.city.toString();
      //can define and add more here
    });

    //return Future.value(data);
  }

  //Hantar data ke server
  postData() async {
    var response =
        await http.post(Uri.parse('http://localhost/simpandata.php'), body: {
      'name': xNama,
      'latitude': xLat.toString(),
      'longitude': xLong.toString(),
      'tarikh': xTarikh!.toString(),
    });
    var responseSelepasHantarData = convert.jsonDecode(response.body);
    print(response);
  }

  //type "ini" Enter dan tambah _getUserLocation
  @override
  void initState() {
    super.initState();
    _getUserLocation(); //tambah function ini
  }

  //-----
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kehadiran Masuk'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text('Nama User: '),
              const SizedBox(height: 20,),
              const Text('Tarikh & Masa', style: TextStyle(fontSize: 20),),
              Text('$tarikh , $masa'),
              const SizedBox(
                height: 20,
              ),
               const Text('Status', style: TextStyle(fontSize: 20) ),

              //dropdown saya
              DropdownButton(
      value: selectedValue,
      onChanged: (String? newValue){
        setState(() {
          selectedValue = newValue!;
        });
      },
      items: dropdownItems
      ),

              const SizedBox(
                height: 20,
              ),
              const Text('Alamat Lokasi:', style: TextStyle(fontSize: 20)),
              _userLocation != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        children: [
                          Text('Latitude: ${_userLocation?.latitude}, Longitude: ${_userLocation?.longitude}'),
                          const SizedBox(width: 10),
                          Text('Alamat: $alamat'),
                          const SizedBox(width: 10),
                          Text('Your City: $city'),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          const Text('Tiada Lokasi. Sila Refresh!'),
                          TextButton.icon(onPressed: () {
                            //code
                            _getUserLocation();
                          }, icon: const Icon(Icons.refresh), label: const Text('Refresh')),
                        ],
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      //code
                      //1. hantar data ke server
                      //postData();

                      //2. selepas hantar, pergi ke page ne
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) =>
                              const StatusSelepasDaftarMasuk());
                      Navigator.push(context, route);
                    },
                    child: const Text('Clock-In')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
