import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/ui/components/dialogs.dart';
import 'package:flutter_banco_douro/ui/widgets/nfc_reading_widget.dart';
import 'package:flutter_banco_douro/ui/widgets/nfc_start_read_widget.dart';

class NfcReadScreen extends StatefulWidget {
  const NfcReadScreen({super.key});

  @override
  State<NfcReadScreen> createState() => _NfcReadScreenState();
}

class _NfcReadScreenState extends State<NfcReadScreen> {
  bool isStartedRead = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            _buildSubScreen(),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  _resetDataAndBack();
                },
                child: const Text("Perdi meu cartão ou estou tendo problemas."),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubScreen() {
    if (isStartedRead) {
      return const NfcReadingWidget();
    } else {
      return NfcStartReadWidget(
        onStartReadButtonClicked: () {
          _startReadNfc();
        },
      );
    }
  }

  _startReadNfc() {
    setState(() {
      isStartedRead = true;
    });
    // TODO:
    // Ler cartão e verificar no dados locais
  }

  void showWrongCardDialog() {
    setState(() {
      isStartedRead = false;
    });

    showOKDialog(
      context: context,
      title: "Atenção",
      content: "O cartão aproximado não é o cadastrado, tente novamente.",
    );
  }

  void _resetDataAndBack() async {
    // TODO
    // Limpar dados salvos
    // Parar a leitura
    // Voltar para tela de login
  }
}
