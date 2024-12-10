import 'package:alinea/controller/invoice/invoice_controller.dart';
import 'package:alinea/controller/invoice/riwayat_invoice_controller.dart';
import 'package:alinea/model/borrowing/borrowing_model.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/appbar/appbar_default.dart';
import 'package:alinea/widgets/appbar/appbar_secondary.dart';
import 'package:alinea/widgets/button/button_action.dart';
import 'package:alinea/widgets/button/button_icon.dart';
import 'package:alinea/widgets/button/button_list_profile.dart';
import 'package:alinea/widgets/button/button_primary.dart';
import 'package:alinea/widgets/shimmer/shimmer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DendaPage extends StatefulWidget {
  const DendaPage({super.key});

  @override
  _DendaPageState createState() => _DendaPageState();
}

class _DendaPageState extends State<DendaPage> {
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBg,
      body: Column(
        children: [
          AppBarSecondary(
            title: "Denda",
          ),
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              controller: refreshController,
              onRefresh: () async {
                refreshController.refreshCompleted();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: kColorBg,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetConstant.underConstructionWide,
                    ),
                    Text(
                      "The feature will be available soon.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
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

//   child: SingleChildScrollView(
            //     child: ListView.builder(
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //       shrinkWrap: true,
            //       physics: const NeverScrollableScrollPhysics(),
            //       itemCount: 1,
            //       itemBuilder: (BuildContext context, int index) {
            //         return Container(
            //             margin: const EdgeInsets.only(bottom: 12),
            //             padding: const EdgeInsets.symmetric(
            //                 vertical: 8, horizontal: 16),
            //             width: Get.width,
            //             decoration: BoxDecoration(
            //               color: const Color(0XFFE0E8F9),
            //               borderRadius: BorderRadius.circular(9),
            //             ),
                        // child: Column(
                        //   children: [
                        //     Image.asset(AssetConstant.underConstructionImg),
                        //     Text("Fitur Under Construction"),
                        //   ],
                        // ));
            //       },
            //     ),
            //   ),
            // ),