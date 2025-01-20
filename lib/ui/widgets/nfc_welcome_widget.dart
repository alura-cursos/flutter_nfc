import 'package:flutter/material.dart';

class NfcWelcomeWidget extends StatelessWidget {
  const NfcWelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16,
      children: [
        Image.asset(
          "assets/images/credit_card.png",
          width: 256,
        ),
        const Text(
          "Mais segurança!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Para segurança, vamos configurar uma segunda etapa de autenticação!",
          textAlign: TextAlign.center,
        ),
        const Text(
          "Tenha em mãos seu cartão do Banco D'Ouro.",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
