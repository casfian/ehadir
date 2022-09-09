import 'package:ehadir/mainmenu.dart';
import 'package:ehadir/mainpage.dart';
import 'package:flutter/material.dart';

class StatusSelepasDaftarMasuk extends StatelessWidget {
  const StatusSelepasDaftarMasuk({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Selepas Daftar Masuk'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Laporan status anda telah diterima'),
            Text('Terima Kasih diatas kehadiran anda.'),
            ElevatedButton(
                onPressed: () {
                  //code
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (context) => Mainmenu());
                  Navigator.pushAndRemoveUntil(
                      context, route, (route) => false);
                },
                child: const Text('Main Menu')),
            
            ElevatedButton(
                onPressed: () {
                  //code
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (context) => Mainpage());
                  Navigator.pushAndRemoveUntil(
                      context, route, (route) => false);
                },
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
