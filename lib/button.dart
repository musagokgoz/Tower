import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final child;
  final function;

  const MyButton({Key key, this.child, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 160,
            height: 80,
            padding: EdgeInsets.all(20),
            color: Colors.grey[900],
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
