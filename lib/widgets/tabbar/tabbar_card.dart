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
          color: isActive ? Theme.of(context).primaryColor : Colors.white,
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
                  fontSize: 12,
                  color:
                      isActive ? Colors.white : Theme.of(context).primaryColor,
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
