import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBooks extends StatelessWidget {
  const ShimmerBooks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Container(
              width: Get.width,
              height: Get.height * 0.2,
              color: Colors.grey.shade300,
            ),
          ),
          SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: Get.width * 0.6,
              height: 16,
              color: Colors.grey.shade300,
            ),
          ),
          SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: Get.width * 0.6,
              height: 16,
              color: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerCarouselBooks extends StatelessWidget {
  const ShimmerCarouselBooks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Container(
                width: 95,
                height: Get.height * 0.18,
                color: Colors.grey.shade300,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 20,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 15,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 15,
                      width: 100,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 30,
                      width: 90,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerProfile extends StatelessWidget {
  const ShimmerProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade50,
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(60), // Border radius untuk CircleAvatar
              child: Container(
                width: 70,
                height: 70,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(5), // Border radius untuk teks
                  child: Container(
                    width: 200,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: 150,
                    height: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: 180,
                    height: 14,
                    color: Colors.grey.shade200,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CartItemTileShimmer extends StatelessWidget {
  const CartItemTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Container(
            width: 20,
            height: 20,
            color: Colors.grey.shade300,
          ),
          const SizedBox(width: 10),
          // Shimmer untuk gambar thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 80,
              height: 120,
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(width: 10),
          // Shimmer untuk teks title dan author
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: double.infinity,
                    height: 18,
                    color: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(height: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: 150,
                    height: 18,
                    color: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: 80,
                        height: 25,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: 80,
                    height: 16,
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
