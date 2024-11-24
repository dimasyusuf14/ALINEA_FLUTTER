import 'package:alinea/model/main/item_navbar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ButtonIcon extends StatelessWidget {
  const ButtonIcon({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.bgcolor,
    required this.iccolor,
  }) : super(key: key);
  final VoidCallback onTap;
  final String icon;
  final Color bgcolor;
  final Color iccolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(4),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: SvgPicture.asset(
                icon,
                width: 30,
                color: iccolor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
