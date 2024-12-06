import 'package:alinea/widgets/shimmer/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class ShimmerGrid extends StatelessWidget {
  const ShimmerGrid({Key? key, required this.count, required this.heightCard})
      : super(key: key);
  final int count;
  final double heightCard;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: count,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        crossAxisCount: 2,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return ShimmerWidget(
            width: Get.width,
            height: heightCard,
          );
        });
  }
}