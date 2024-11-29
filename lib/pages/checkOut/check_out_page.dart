import 'dart:ui';

import 'package:alinea/widgets/appbar/appbar_default.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedBooks = Get.arguments as List<Map<String, dynamic>>;

    return Scaffold(
      body: Column(
        children: [
          AppBarDefault(title: "Checkout"),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                itemCount: selectedBooks.length,
                itemBuilder: (context, index) {
                  final book = selectedBooks[index];
                  return ListTile(
                    leading: Image.network(
                      book['coverUrl'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 50);
                      },
                    ),
                    title: Text(book['title']),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
