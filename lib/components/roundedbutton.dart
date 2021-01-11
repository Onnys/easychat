import 'package:flutter/material.dart';
class RoundedButton extends StatelessWidget {
  RoundedButton({
   this.color, this.title, @required this.onPressed
  });
  final Color color;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(title),
        ),
      ),
    );
  }
}
