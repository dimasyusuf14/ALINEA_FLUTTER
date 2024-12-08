import 'package:flutter/material.dart';

class ButtonAction extends StatelessWidget {
  const ButtonAction(
      {Key? key, required this.onTap, required this.child, this.padding = 8.0})
      : super(key: key);
  final VoidCallback onTap;
  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: child,
        ),
      ),
    );
  }
}
