import 'package:flutter/material.dart';
void main() {
  
}



class ButonTurleri extends StatefulWidget {
  const ButonTurleri({super.key});

  @override
  State<ButonTurleri> createState() => _ButonTurleriState();
}

class _ButonTurleriState extends State<ButonTurleri> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(onPressed: () {},
        style: OutlinedButton.styleFrom(shape:StadiumBorder(),
        side: BorderSide(color: Colors.black, width: 3),), child: Text("TRANSLATE"),
        ),
      ],
    );
  }
}