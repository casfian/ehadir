import 'package:ehadir/daftarmasuk.dart';
import 'package:ehadir/mainmenu.dart';
import 'package:ehadir/salahmasuk.dart';
import 'package:flutter/material.dart';

class Mainpage extends StatelessWidget {
  Mainpage({super.key});

  //declare
  final pengenalanController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('eHadir'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: [
                const Text('Sila Login'),
                Image.asset(
                  'images/jata.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: pengenalanController,
                  decoration: InputDecoration(
                    prefix: const Icon(Icons.card_membership),
                    filled: true,
                    fillColor: Colors.blue.shade100,
                    enabled: true,
                    hintText: 'Sila masukkan kad pengenalan anda',
                    labelText: 'Kad Pengenalan:',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefix: const Icon(Icons.security),
                    filled: true,
                    fillColor: Colors.blue.shade100,
                    enabled: true,
                    hintText: 'katalaluan kena 12 aksara',
                    labelText: 'Katalaluan:',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () {
                        //logik
                        //1. kita hantar maklumat kad pengenalan dan password ke server
                        //rujuk Lesson 10 yg saya bagi

                        //2. bila kita dapat response dari server

                        //3. kalau ada maklumat itu valid maka pergi ke page seterusnya
                        if (pengenalanController.text == '123456789012' &&
                            passwordController.text == '000000') {
                          MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) => const Mainmenu());
                          Navigator.push(context, route);
                        } else {
                          MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) => const Salah());
                          Navigator.push(context, route);
                        }
                      },
                      child: const Text('Masuk')),
                ),
                TextButton(
                    onPressed: () {
                      //code
                    },
                    child: const Text('Lupa Katalaluan'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
