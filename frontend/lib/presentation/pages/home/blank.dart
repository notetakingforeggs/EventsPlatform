import 'package:flutter/material.dart';

class Blank extends StatelessWidget {
  const Blank({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 20,
        ),
        ClipOval(
            child: Image.asset('assets/images/limbs.jpeg', fit: BoxFit.cover)),
        Text(
          "Circus Events",
          style: TextStyle(fontSize: 64),
        ),
      ],
    );
  }
}
