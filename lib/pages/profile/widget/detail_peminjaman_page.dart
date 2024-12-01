import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/appbar/appbar_default.dart';
import 'package:alinea/widgets/appbar/appbar_secondary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DetailPeminjamanPage extends StatefulWidget {
  const DetailPeminjamanPage({super.key});

  @override
  _DetailPeminjamanPageState createState() => _DetailPeminjamanPageState();
}

class _DetailPeminjamanPageState extends State<DetailPeminjamanPage> {
  bool isExpanded =
      false; // Menyimpan status apakah data ditampilkan penuh atau tidak

  final books = [
    {
      'title': 'QWERTY UYTREWQ',
      'author': 'Ujang Surajang',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBarSecondary(
            title: "Detail Peminjaman",
            
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Color(0XFFE0E8F9),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ALN202411281341",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kColorPrimary,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: kColorSecondary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                child: Text(
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
                          Divider(
                            color: kColorPrimary,
                            height: 5,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          // AnimatedSize untuk transisi yang smooth
                          AnimatedSize(
                            duration:
                                Duration(milliseconds: 300), // Durasi transisi
                            curve: Curves.easeInOut, // Kurva animasi
                            child: ListView.builder(
                              shrinkWrap:
                                  true, // Penting untuk ListView di dalam Column
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: isExpanded
                                  ? books.length
                                  : 1, // Menampilkan satu atau seluruh data
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                final book = books[index];
                                return Container(
                                  margin: EdgeInsets.only(bottom: 5),
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
                                      const SizedBox(
                                        width: 12,
                                      ), // Spasi antara gambar dan teks
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            book['title']!,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            book['author']!,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(book['quantity']!),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded =
                                    !isExpanded; // Toggle antara tampilan satu data atau seluruh data
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isExpanded
                                      ? "Lihat Lebih Sedikit"
                                      : "Lihat Semua",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: kColorPrimary,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.asset(
                                  isExpanded
                                      ? AssetConstant.icUpArrow
                                      : AssetConstant.icDropDown,
                                  color: kColorPrimary,
                                  width: 15,
                                )
                              ],
                            ),
                          ),
                        ],
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
