

import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/appbar/appbar_default.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RiwayatPeminjamanPage extends StatelessWidget {
  const RiwayatPeminjamanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBarDefault(title: "Riwayat Peminjaman"),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "202411281341	",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kColorPrimary,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                           
                            Container(
                              decoration: BoxDecoration(
                                color: kColorSecondary,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "Clear",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: kColorBg),
                              ),
                            ),
                          ],
                        ),
                         Text(
                          "2024-12-11",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(" • "),
                        Text(
                          "2024-12-12",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
