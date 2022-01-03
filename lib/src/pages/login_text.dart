import 'package:flutter/material.dart';

class LoginText extends StatelessWidget {
  const LoginText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.w600
      ),
    );
  }
}

