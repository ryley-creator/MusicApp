import 'package:flutter/material.dart';

class CategoryBox extends StatelessWidget {
  const CategoryBox({super.key, required this.text, required this.onTap});
  final String text;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).canvasColor,
          border: Border(
            top: BorderSide(
              width: 0.5,
              color: Theme.of(context).appBarTheme.foregroundColor!,
            ),
            bottom: BorderSide(
              width: 0.5,
              color: Theme.of(context).appBarTheme.foregroundColor!,
            ),
            left: BorderSide(
              width: 0.5,
              color: Theme.of(context).appBarTheme.foregroundColor!,
            ),
            right: BorderSide(
              width: 0.5,
              color: Theme.of(context).appBarTheme.foregroundColor!,
            ),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 26,
              color: Theme.of(context).textTheme.titleMedium!.color,
            ),
          ),
        ),
      ),
    );
  }
}
