import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../services/utilities/utilities.dart';

class AppBarDefault extends StatelessWidget {
  const AppBarDefault(
      {super.key,
      this.isWithBack = true,
      required this.title,
      this.actions = const [],
      this.subtitle = "",
      this.onTapBack = defaultTap});
  final bool isWithBack;
  final String title, subtitle;
  final List<Widget> actions;
  final VoidCallback onTapBack;

  static defaultTap() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top,
      ),
      decoration: BoxDecoration(
        color: kColorPrimary,
        border: Border.all(
          color: kColorSecondary,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AssetConstant.icKeranjang,
              width: 25,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: actions,
            ),
          ],
        ),
      ),
    );
  }
}
