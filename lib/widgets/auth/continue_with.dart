import 'package:flutter/material.dart';

class ContinueWith extends StatelessWidget {
  const ContinueWith({super.key, required this.text, required this.widget});
  final String text;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('- OR Continue with -'),
          SizedBox(height: 20),
          SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(text), widget],
          ),
        ],
      ),
    );
  }
}
