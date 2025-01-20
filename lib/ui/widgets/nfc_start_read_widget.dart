import 'package:flutter/material.dart';
import '../styles/colors.dart';

class NfcStartReadWidget extends StatelessWidget {
  final Function onStartReadButtonClicked;

  const NfcStartReadWidget({
    super.key,
    required this.onStartReadButtonClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        Image.asset(
          "assets/images/credit_card.png",
          width: 256,
        ),
        ElevatedButton(
          onPressed: () {
            onStartReadButtonClicked();
          },
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColor.orange),
          ),
          child: const Text(
            "Iniciar leitura",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        const Text(
          "Tenha em mãos seu douradinho!",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
