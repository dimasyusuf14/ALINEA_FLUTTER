import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    required this.assetName,
    required this.title,
    required this.onPressed,
    required this.color,
    required this.titleColor,
    required this.jumlahData,
  });
  final VoidCallback onPressed;
  final String assetName;
  final String title;
  final String jumlahData;
  final Color titleColor;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: Get.height * 0.07,
            width: Get.width * 0.5,
            child: Row(
              children: [
                SvgPicture.asset(
                  assetName,
                  width: 30,
                  height: 30,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: titleColor,
                  ),
                ),
                Text(
                  jumlahData,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
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
