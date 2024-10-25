import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Buttontext extends StatelessWidget {
  const Buttontext({
    super.key,
    required this.onTap,
    required this.title,
  });
  final VoidCallback onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          color: Color(0XFF445DCC),
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
      ),
    );
  }
}
