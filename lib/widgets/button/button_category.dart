import 'package:alinea/model/main/item_navbar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ButtonCategory extends StatelessWidget {
  const ButtonCategory({
    super.key,
    required this.onTap,
    required this.icon,
    required this.bgcolor,
    required this.iccolor,
    required this.title,
  });
  final VoidCallback onTap;
  final String icon;
  final String title;
  final Color bgcolor;
  final Color iccolor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(9),
            onTap: onTap,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: bgcolor,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  width: 50,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      icon,
                      width: 25,
                      color: iccolor,
                    ),
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
