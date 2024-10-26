import 'package:flutter/material.dart';

class TabbarCard extends StatelessWidget {
  const TabbarCard({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
    required this.isFirstIndex,
  });

  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final bool isFirstIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? Color(0XFF445DCC) : Color(0XFFC9CCF4),
          borderRadius: isFirstIndex
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  topLeft: Radius.circular(6),
                )
              : const BorderRadius.only(
                  bottomRight: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color:
                      isActive ? Color(0XFFC9CCF4) : Color(0XFF445DCC),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
