import 'package:flutter/material.dart';

class MyPixel extends StatelessWidget {
  final color;

  const MyPixel({Key key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          color: color,
        ),
      ),
    );
  }
}
