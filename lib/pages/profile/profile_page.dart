// profile_page.dart
import 'package:alinea/controller/auth_controller.dart';
import 'package:alinea/utilities/asset_constant.dart';
import 'package:alinea/widgets/button/button_list_profile.dart';
import 'package:alinea/widgets/button/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: Get.width * 0.7,
          width: Get.width,
          decoration: BoxDecoration(
            color: Color(0XFF5878D9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 60,
            ),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(AssetConstant.profilePict),
                ),
                SizedBox(height: 20),
                Text(
                  "User Name",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "user@example.com",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ButtonListProfile(
                  onPressed: () {},
                  assetName: AssetConstant.icBookmark,
                  title: 'Detail Peminjaman',
                  color: Color(0xFFE0E8F9),
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonListProfile(
                  onPressed: () {},
                  assetName: AssetConstant.icRiwayat,
                  title: 'Riwayat Peminjaman',
                  color: Color(0xFFE0E8F9),
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonListProfile(
                  onPressed: () {},
                  assetName: AssetConstant.icDenda,
                  title: 'Denda',
                  color: Color(0xFFE0E8F9),
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonListProfile(
                  onPressed: () {
                    _authController.logout();
                  },
                  assetName: AssetConstant.icLogout,
                  title: 'Keluar',
                  color: Colors.red,
                ),

                // Container(
                //   height: Get.height * 0.08,
                //   width: Get.width * 0.9,
                //   decoration: BoxDecoration(
                //     color: Colors.red,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: Row(
                //     children: [
                //       IconButton(
                //         onPressed: () {
                //           _authController.logout();
                //           // overlayEntry.remove();
                //         },
                //         icon: Icon(Icons.logout), // Logout icon
                //       ),
                //       Text(
                //         "Keluar",
                //         style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
