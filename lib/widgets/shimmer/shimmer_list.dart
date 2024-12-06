import 'package:alinea/widgets/shimmer/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({
    Key? key,
    required this.count,
    required this.heightCard,
    this.margin,
  }) : super(key: key);

  final int count;
  final double heightCard;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: count,
      itemBuilder: (context, index) {
        return Container(
          margin: margin ??
              EdgeInsets.only(
                top: index == 0 ? 16 : 0,
                left: 16,
                right: 16,
                bottom: 8,
              ),
          child: ShimmerWidget(
            width: Get.width,
            height: heightCard,
          ),
        );
      },
    );
  }
}