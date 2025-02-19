import 'package:flutter/material.dart';



class doprbutton extends StatefulWidget {
  const doprbutton({super.key});

  @override
  State<doprbutton> createState() => _doprbuttonState();
}

class _doprbuttonState extends State<doprbutton> {
  String? _secilenDil;
  final List<String>_tumDiller =['Türkçe', 'İngilizce', 'Almanca', 'İspanyolca'];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        hint: Text("Dil Seçiniz"),
        icon: Icon(Icons.arrow_back_ios_new_sharp),
        iconSize: 12,
        items: _tumDiller.map((String oankiDil) => DropdownMenuItem(value: oankiDil,child: Text(oankiDil),),).toList(),
        onChanged: (String? yeni){
          setState(() {
            _secilenDil = yeni;
          });
        },
      value: _secilenDil,),
    );
  }
}