import 'package:ehadir/daftarkeluar.dart';
import 'package:ehadir/daftarmasuk.dart';
import 'package:ehadir/mainpage.dart';
import 'package:flutter/material.dart';

class Mainmenu extends StatelessWidget {
  const Mainmenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Menu Utama'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image.asset(
                  'images/jata.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                    ),
                      onPressed: () {
                        //code
                        MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => Daftarmasuk());
                        Navigator.push(context, route);
                      },
                      child: const Text('Daftar Masuk')),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                    ),
                      onPressed: () {
                        //code
                        MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => const Daftarkeluar());
                        Navigator.push(context, route);
                      },
                      child: const Text('Daftar Keluar')),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(onPressed: () {
                      //code
                    }, 
                    label: const Text('Rekod'),
                    icon: const Icon(Icons.list)),

                    TextButton.icon(onPressed: () {
                      //code
                    }, 
                    label: const Text('Tukar'),
                    icon: const Icon(Icons.security_update)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        //code
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) => Mainpage());
                        Navigator.pushAndRemoveUntil(
                            context, route, (route) => false);
                      },
                      child: const Text('Logout')),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
