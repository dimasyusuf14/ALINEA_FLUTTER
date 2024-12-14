import 'package:alinea/model/main/item_navbar_model.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ItemNavbar extends StatelessWidget {
  const ItemNavbar(
      {Key? key,
      required this.onTap,
      required this.isActive,
      required this.model})
      : super(key: key);
  final VoidCallback onTap;
  final bool isActive;
  final ItemNavbarModel model;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            const SizedBox(
              height: 8.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: isActive ? kColorPrimary : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SvgPicture.asset(
                model.icon,
                width: isActive ? 18 : 20,
                color: isActive ? Colors.white : kColorPrimary,
              ),
            ),
            Text(
              model.title.tr,
              style: TextStyle(
                color: isActive ? kColorPrimary : Colors.indigo[900],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
