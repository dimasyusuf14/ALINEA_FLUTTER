import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final Function onConfirm;
  final Function onCancel;

  DeleteConfirmationDialog({required this.onConfirm, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Keluar",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Apakah Kamu Yakin Untuk Keluar Dari Aplikasi?",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  onPressed: () => onCancel(),
                  child: const Text("Batal"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    backgroundColor: const Color.fromARGB(255, 255, 40, 40),
                  ),
                  onPressed: () => onConfirm(),
                  child: const Text(
                    "Keluar",
                    style: TextStyle(color: Colors.white),
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

// To show the modal dialog on a button press or an event:
void showDeleteConfirmationDialog(
    BuildContext context, Function onConfirm, Function onCancel) {
  showDialog(
    context: context,
    barrierDismissible:
        true, // Allows the background to be clicked to dismiss the modal
    builder: (BuildContext context) {
      return DeleteConfirmationDialog(onConfirm: onConfirm, onCancel: onCancel);
    },
  );
}
