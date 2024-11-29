import 'package:alinea/controller/auth/login/login_controller.dart';
import 'package:alinea/controller/profile/profile_controller.dart';
import 'package:alinea/pages/profile/widget/show_modal_form.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/button/button_list_profile.dart';
import 'package:alinea/widgets/dialog/confirm_delete_dialog.dart';
import 'package:alinea/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Get.height * 0.40,
            width: Get.width,
            decoration: BoxDecoration(
              color: Color(0XFF5878D9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 60,
              ),
              child: Obx(() {
                // Check loading status for the profile data
                if (profileController.loadingProfile.value == DataLoad.loading) {
                  return Center(
                    child: ShimmerProfile(),
                  );
                } else if (profileController.loadingProfile.value == DataLoad.failed) {
                  return Center(child: Text("Failed to load profile data."));
                }

                // Retrieve user profile data from the controller
                final user = profileController.userProfile.value;

                return Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: user.image != null
                          ? NetworkImage(user.image)
                          : AssetImage(AssetConstant.nullprofilePict)
                              as ImageProvider,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "${user.firstName} ${user.lastName}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "NIM: ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          user.nim,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      user.email,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ButtonListProfile(
                      onPressed: () {
                        showModalForm(context, profileController);
                      },
                      assetName: AssetConstant.icEdit,
                      title: 'Edit Informasi Saya',
                      color: Color(0xFFE0E8F9),
                      titleColor: Colors.black,
                    ),
                    SizedBox(height: 10),
                    ButtonListProfile(
                      onPressed: () {
                        Get.toNamed(RouteName.detailPeminjamanPage);
                      },
                      assetName: AssetConstant.icBookmark,
                      title: 'Detail Peminjaman',
                      color: Color(0xFFE0E8F9),
                      titleColor: Colors.black,
                    ),
                    SizedBox(height: 10),
                    ButtonListProfile(
                      onPressed: () {
                        Get.toNamed(RouteName.riwayatPeminjamanPage);
                      },
                      assetName: AssetConstant.icRiwayat,
                      title: 'Riwayat Peminjaman',
                      color: Color(0xFFE0E8F9),
                      titleColor: Colors.black,
                    ),
                    SizedBox(height: 10),
                    ButtonListProfile(
                      onPressed: () {
                        Get.toNamed(RouteName.dendaPage);
                      },
                      assetName: AssetConstant.icDenda,
                      title: 'Denda',
                      color: Color(0xFFE0E8F9),
                      titleColor: Colors.black,
                    ),
                    SizedBox(height: 10),
                    ButtonListProfile(
                      onPressed: () {
                        showDeleteConfirmationDialog(
                          context,
                          () {
                            LoginController().logout();
                          },
                          () {
                            Navigator.of(context).pop();
                          },
                        );
                      },
                      assetName: AssetConstant.icLogout,
                      title: 'Keluar',
                      color: Colors.red,
                      titleColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
