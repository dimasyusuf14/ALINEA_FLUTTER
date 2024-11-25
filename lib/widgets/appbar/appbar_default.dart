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
          top: MediaQuery.of(context).viewPadding.top + 16, bottom: 18),
      decoration: const BoxDecoration(
        color: kColorPrimary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                // Navigator.pop(context);
              },
              child: SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(
                  AssetConstant.icKeranjang,
                  fit: BoxFit.fill,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
