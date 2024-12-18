import 'package:alinea/controller/auth/login/login_controller.dart';
import 'package:alinea/controller/invoice/invoice_controller.dart';
import 'package:alinea/controller/profile/profile_controller.dart';
import 'package:alinea/model/borrowing/borrowing_model.dart';
import 'package:alinea/pages/profile/widget/show_modal_form.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/button/button_list_profile.dart';
import 'package:alinea/widgets/dialog/confirm_delete_dialog.dart';
import 'package:alinea/widgets/shimmer/shimmer_list.dart';
import 'package:alinea/widgets/shimmer/shimmer_loading.dart';
import 'package:alinea/widgets/try_again_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 200,
            ),
            decoration: BoxDecoration(
              color: Color(0XFF5878D9),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('assets/images/book.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Obx(
              () {
                if (profileController.loadingProfile.value ==
                    DataLoad.loading) {
                  return Center(
                    child: ShimmerProfile(),
                  );
                } else if (profileController.loadingProfile.value ==
                    DataLoad.failed) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: TryAgainWidget(
                        child: ShimmerList(
                          count: 5,
                          heightCard: 80,
                        ),
                        onTapTryAgain: () async {
                          refreshController.refreshCompleted();
                          profileController.fetchUserProfile();
                        },
                      ),
                    ),
                  );
                }

                final user = profileController.userProfile.value;

                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: user.image != null
                            ? NetworkImage(user.imageUrl)
                            : AssetImage('assets/images/null_profile.jpg')
                                as ImageProvider,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${user.firstName} ${user.lastName}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              user.nim,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              user.email,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              controller: refreshController,
              onRefresh: () async {
                profileController.fetchUserProfile();
                refreshController.refreshCompleted();
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
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
                          Get.toNamed(RouteName.dendaPeminjamanPage);
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
          ),
        ],
      ),
    );
  }
}
