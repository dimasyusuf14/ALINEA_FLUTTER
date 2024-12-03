import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/appbar/appbar_default.dart';
import 'package:alinea/widgets/appbar/appbar_secondary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RiwayatPeminjamanPage extends StatefulWidget {
  const RiwayatPeminjamanPage({super.key});

  @override
  _RiwayatPeminjamanPageState createState() => _RiwayatPeminjamanPageState();
}

class _RiwayatPeminjamanPageState extends State<RiwayatPeminjamanPage> {
  int? expandedIndex; // Index dari container yang sedang expanded

  final books = [
    {
      'title': 'QWERTY UYTREWQ',
      'author': 'UjANG Surajang',
      'quantity': 'x1',
      'cover': AssetConstant.coverHarryPoter,
    },
    {
      'title': 'Lorem Ipsum',
      'author': 'John Doe',
      'quantity': 'x2',
      'cover': AssetConstant.coverHarryPoter,
    },
    {
      'title': 'Flutter for Beginners',
      'author': 'Jane Doe',
      'quantity': 'x3',
      'cover': AssetConstant.coverHarryPoter,
    },
  ];
  RefreshController refreshController = RefreshController();

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
              },
              child: SingleChildScrollView(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
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
                          // Header dengan ID dan status
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ALN20241128134${index + 1}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kColorPrimary,
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: kColorSecondary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                child: const Text(
                                  "Clear",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: kColorBg),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          // Tanggal peminjaman
                          Row(
                            children: const [
                              Text(
                                "01 December 2024",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                " - ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "08 December 2024",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: kColorPrimary,
                            height: 10,
                          ),
                          const SizedBox(height: 8),

                          // Konten buku
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: expandedIndex == index
                                  ? books.length
                                  : 1, // Perluas hanya container yang aktif
                              itemBuilder: (context, bookIndex) {
                                final book = books[bookIndex];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 5),
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
                                          child: Image.asset(
                                            book['cover']!,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
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
                                          Text(
                                            book['title']!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            book['author']!,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(book['quantity']!),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Tombol toggle lihat semua
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (expandedIndex == index) {
                                  expandedIndex =
                                      null; // Tutup jika sudah aktif
                                } else {
                                  expandedIndex = index; // Aktifkan index baru
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                            ),
                          ),
                        ],
                      ),
                    );
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
