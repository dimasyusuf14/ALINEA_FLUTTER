import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../services/utilities/utilities.dart';

class AppBarDefault extends StatelessWidget {
  const AppBarDefault({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top + 16, bottom: 22),
        decoration: const BoxDecoration(
          color: Color(0XFFC9D6F4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // InkWell(
              //   onTap: () {
              //     // Navigator.pop(context);
              //   },
              //   child: SizedBox(
              //     height: 28,
              //     width: 25,
              //     child: SvgPicture.asset(
              //       AssetConstant.icBack,
              //       fit: BoxFit.fill,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   width: 15,
              // ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ));
  }
}
