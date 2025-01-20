import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NfcNotValidWidget extends StatelessWidget {
  const NfcNotValidWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          Lottie.asset(
            "assets/lotties/nfc_error.json",
            height: 256,
            repeat: false,
          ),
          const Text(
            "NFC não disponível",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
