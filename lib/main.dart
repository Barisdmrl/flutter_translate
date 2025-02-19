import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text("ÇEVİRİ UYGULAMASI"),
        ),
        body: Center( // 📌 **Tüm içeriği ekranın ortasına almak için** Center kullanıldı
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20), // Resim ile buton grubu arasında boşluk

              // 📌 **Butonları yatayda hizalamak için Row kullanıldı**
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // **Tam ortalamak için**
                children: [
                  doprbutton(), // Dil seçme dropdown
                  SizedBox(width: 10), // İki buton arasına boşluk ekle
                  ButonTurleri(), // Translate butonu
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 📌 **Dropdown Butonu (Dil Seçme)**
class doprbutton extends StatefulWidget {
  const doprbutton({super.key});

  @override
  State<doprbutton> createState() => _doprbuttonState();
}

class _doprbuttonState extends State<doprbutton> {
  String? _secilenDil;
  List<String> _tumDiller = ['Türkçe', 'İngilizce', 'Almanca', 'İspanyolca'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text("Dil Seçiniz"),
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      items: _tumDiller
          .map(
            (String oankiDil) => DropdownMenuItem(
              child: Text(oankiDil),
              value: oankiDil,
            ),
          )
          .toList(),
      onChanged: (String? yeni) {
        setState(() {
          _secilenDil = yeni;
        });
      },
      value: _secilenDil,
    );
  }
}

// 📌 **Translate Butonu**
class ButonTurleri extends StatefulWidget {
  const ButonTurleri({super.key});

  @override
  State<ButonTurleri> createState() => _ButonTurleriState();
}

class _ButonTurleriState extends State<ButonTurleri> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: Text("TRANSLATE"),
      style: OutlinedButton.styleFrom(
        shape: StadiumBorder(),
        side: BorderSide(color: Colors.black, width: 3),
      ),
    );
  }
}
