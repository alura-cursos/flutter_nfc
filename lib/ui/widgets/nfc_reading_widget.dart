import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NfcReadingWidget extends StatelessWidget {
  const NfcReadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          Lottie.asset(
            "assets/lotties/nfc_reading.json",
            height: 256,
            repeat: true,
          ),
          const Text(
            "Aproxime seu douradinho!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
