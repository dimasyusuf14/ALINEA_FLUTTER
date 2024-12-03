import 'package:alinea/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Buttonprimary extends StatelessWidget {
  Buttonprimary({
    super.key,
    // required this.onTap,
    required this.title,
    required this.color,
    required this.width,
    required this.onPressed,
    this.fontSize = 18,
  });
  final VoidCallback onPressed;
  final String title;
  final Color color;
  final double width;
  final double fontSize;
  


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(9),
          onTap: onPressed,
          splashColor: Colors.white24, // Warna efek tap
          highlightColor: Colors.white10,
          child: Container(
            width: width,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
