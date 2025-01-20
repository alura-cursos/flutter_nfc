import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NfcFinishedWidget extends StatelessWidget {
  const NfcFinishedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          Lottie.asset(
            "assets/lotties/check.json",
            height: 256,
            repeat: false,
          ),
          const Text(
            "Seu douradinho foi registrado! :D",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
