import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/utilities.dart';

class AppBarDefault extends StatelessWidget {
  const AppBarDefault({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top + 16, bottom: 22),
      decoration: const BoxDecoration(color: kColorWhite),
      child: SizedBox(),
    );
  }
}
