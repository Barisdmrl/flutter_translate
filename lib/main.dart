import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController inputController = TextEditingController(); // Kullanıcı girdisi
  TextEditingController outputController = TextEditingController(); // Çeviri sonucu

  // Dil Seçimleri
  String? inputLanguage = 'Türkçe'; // Giriş dili
  String? outputLanguage = 'İngilizce'; // Çıktı dili

  // Desteklenen diller
  List<String> languages = ['Türkçe', 'İngilizce', 'Almanca', 'İspanyolca'];

  Future<void> translateText() async {
    String text = inputController.text.trim();
    if (text.isEmpty) return; // Eğer boşsa çeviri yapma

    String sourceLang = _getLanguageCode(inputLanguage!); // Giriş dilinin kodu
    String targetLang = _getLanguageCode(outputLanguage!); // Çıkış dilinin kodu

    final url = Uri.parse(
        "https://api.mymemory.translated.net/get?q=$text&langpair=$sourceLang|$targetLang");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        String translatedText = jsonData["responseData"]["translatedText"];

        setState(() {
          outputController.text = translatedText; // Çeviri sonucunu göster
        });
      } else {
        print("API hatası: ${response.statusCode}");
      }
    } catch (e) {
      print("Bağlantı hatası: $e");
    }
  }

  // Dil isimlerini API'ye uygun dil kodlarına dönüştürür
  String _getLanguageCode(String language) {
    switch (language) {
      case 'Türkçe':
        return 'tr';
      case 'İngilizce':
        return 'en';
      case 'Almanca':
        return 'de';
      case 'İspanyolca':
        return 'es';
      default:
        return 'en'; // Varsayılan dil İngilizce
    }
  }

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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 📌 **Giriş dilini seçme DropdownButton**
                DropdownButton<String>(
                  value: inputLanguage,
                  onChanged: (String? newValue) {
                    setState(() {
                      inputLanguage = newValue;
                    });
                  },
                  items: languages.map<DropdownMenuItem<String>>((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                ),

                SizedBox(height: 10),

                // 📌 **Çevirilecek dili seçme DropdownButton**
                DropdownButton<String>(
                  value: outputLanguage,
                  onChanged: (String? newValue) {
                    setState(() {
                      outputLanguage = newValue;
                    });
                  },
                  items: languages.map<DropdownMenuItem<String>>((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                ),

                SizedBox(height: 20),

                // 📌 **Giriş Metni için TextField**
                Container(
                  width: double.infinity,
                  child: TextField(
                    controller: inputController,
                    textAlign: TextAlign.center,
                    minLines: 1,
                    maxLines: null,
                    maxLength: 200,
                    decoration: InputDecoration(
                      hintText: "Çeviri yapılacak metni giriniz",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // 📌 **Çevirme Butonu**
                OutlinedButton(
                  onPressed: translateText,
                  child: Text("TRANSLATE"),
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    side: BorderSide(color: Colors.black, width: 3),
                  ),
                ),

                SizedBox(height: 20),

                // 📌 **Çeviri Sonucu için TextField**
                Container(
                  width: double.infinity,
                  child: TextField(
                    controller: outputController,
                    textAlign: TextAlign.center,
                    minLines: 1,
                    maxLines: null,
                    readOnly: true, // Kullanıcı değiştiremez
                    decoration: InputDecoration(
                      hintText: "Çeviri Sonucu",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
