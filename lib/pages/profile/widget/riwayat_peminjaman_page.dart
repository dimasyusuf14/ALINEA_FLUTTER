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

class RiwayatPeminjamanPage extends StatefulWidget {
  const RiwayatPeminjamanPage({super.key});

  @override
  _RiwayatPeminjamanPageState createState() => _RiwayatPeminjamanPageState();
}

class _RiwayatPeminjamanPageState extends State<RiwayatPeminjamanPage> {
  int? expandedIndex;
  InvoiceController pdfController = Get.put(InvoiceController());
  RefreshController refreshController = RefreshController();
  RiwayatInvoiceController controller = Get.put(RiwayatInvoiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBg,
      body: Column(
        children: [
          AppBarSecondary(
            title: "Riwayat Peminjaman",
          ),
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              controller: refreshController,
              onRefresh: () async {
                refreshController.refreshCompleted();
                controller.fetchHistoryPeminjaman();
              },
              child: SingleChildScrollView(
                child: Obx(
                  () {
                    if (controller.loadingFetchHistoryPeminjaman.value ==
                        DataLoad.loading) {
                      return ShimmerList(count: 5, heightCard: 250);
                    } else if (controller.loadingFetchHistoryPeminjaman.value ==
                        DataLoad.failed) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "Failed to load data",
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Text(
                              "Check your connection",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.listHistoryPeminjaman.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: const Color(0XFFE0E8F9),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: kColorSecondary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 5),
                                                  child: const Text(
                                                    "Clear",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color: kColorBg,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  "ALN ${controller.listHistoryPeminjaman[index].noInvoice.toString()}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: kColorPrimary,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  controller.formatDate(
                                                      controller
                                                          .listHistoryPeminjaman[
                                                              index]
                                                          .borrowings[0]
                                                          .borrowDate),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  " - ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  controller.formatDate(
                                                      controller
                                                          .listHistoryPeminjaman[
                                                              index]
                                                          .borrowings[0]
                                                          .returnDate),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: kColorPrimary,
                                            ),
                                            SizedBox(
                                              width: 150,
                                              child: ButtonAction(
                                                onTap: () {
                                                  pdfController.downloadPDF(89);
                                                },
                                                padding: 0,
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      AssetConstant.icPdf,
                                                      width: 30,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      "Download PDF",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: kColorPrimary,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: QrImageView(
                                        data: controller
                                            .listHistoryPeminjaman[index]
                                            .noInvoice
                                            .toString(),
                                        version: QrVersions.auto,
                                        size: 70.0,
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Divider(
                                  color: kColorPrimary,
                                  height: 10,
                                ),
                                const SizedBox(height: 8),
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: expandedIndex == index
                                        ? controller
                                            .listHistoryPeminjaman[index]
                                            .borrowings
                                            .length
                                        : 1,
                                    itemBuilder: (context, bookIndex) {
                                      final book = controller
                                          .listHistoryPeminjaman[index]
                                          .borrowings[bookIndex];
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 60,
                                              height: 90,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  book.book.coverUrl,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Icon(
                                                        Icons.broken_image,
                                                        size: 70);
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 255,
                                                  child: Text(
                                                    book.book.title,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  book.book.author,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 10),
                                                Text('1x'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (expandedIndex == index) {
                                        expandedIndex = null;
                                      } else {
                                        expandedIndex = index;
                                      }
                                    });
                                  },
                                  child: Obx(() => controller
                                              .listHistoryPeminjaman[index]
                                              .borrowings
                                              .length >
                                          1
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              expandedIndex == index
                                                  ? "Lihat Lebih Sedikit"
                                                  : "Lihat Semua",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: kColorPrimary,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            SvgPicture.asset(
                                              expandedIndex == index
                                                  ? AssetConstant.icUpArrow
                                                  : AssetConstant.icDropDown,
                                              color: kColorPrimary,
                                              width: 15,
                                            ),
                                          ],
                                        )
                                      : SizedBox()),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
