import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/button/button_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppBarSecondary extends StatelessWidget {
  const AppBarSecondary(
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
          top: MediaQuery.of(context).viewPadding.top + 16, bottom: 22),
      decoration: const BoxDecoration(color: kColorPrimary),
      child: Row(
        children: [
          isWithBack
              ? Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: ButtonIcon(
                          onTap: () {
                            Get.back();
                          },
                          icon: AssetConstant.icBack,
                          bgcolor: Colors.transparent,
                          iccolor: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: isWithBack ? 5 : 24,
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle.isNotEmpty
                                ? Text(
                                    subtitle,
                                    style: TextStyle(fontSize: 12),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            width: 10,
          ),
          Row(
            children: actions,
          ),
          const SizedBox(
            width: 24,
          )
        ],
      ),
    );
  }
}
