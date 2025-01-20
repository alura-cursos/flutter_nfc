import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/ui/styles/colors.dart';
import 'package:flutter_banco_douro/ui/widgets/nfc_finished_widget.dart';
import 'package:flutter_banco_douro/ui/widgets/nfc_not_valid.dart';
import 'package:flutter_banco_douro/ui/widgets/nfc_reading_widget.dart';
import 'widgets/nfc_welcome_widget.dart';

enum _NfcSubScreens {
  welcome,
  notValid,
  readCard,
  finished,
}

class NfcRegisterScreen extends StatefulWidget {
  const NfcRegisterScreen({super.key});

  @override
  State<NfcRegisterScreen> createState() => _NfcRegisterScreenState();
}

class _NfcRegisterScreenState extends State<NfcRegisterScreen> {
  final _NfcSubScreens _currentSubScreen = _NfcSubScreens.welcome;
  bool isReadingNfc = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            _buildCurrentScreen(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 32,
                children: [
                  TextButton(
                    onPressed: () {
                      onBackButtonClicked();
                    },
                    child: const Text(
                      "Voltar",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (isReadingNfc)
                        ? null
                        : () {
                            onNextButtonClicked();
                          },
                    style: ButtonStyle(
                      backgroundColor: (isReadingNfc)
                          ? const WidgetStatePropertyAll(Colors.grey)
                          : const WidgetStatePropertyAll(AppColor.orange),
                    ),
                    child: Text(
                      (_currentSubScreen == _NfcSubScreens.finished ||
                              _currentSubScreen == _NfcSubScreens.notValid)
                          ? "Finalizar"
                          : "Continuar",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentSubScreen) {
      case _NfcSubScreens.welcome:
        return const NfcWelcomeWidget();
      case _NfcSubScreens.notValid:
        return const NfcNotValidWidget();
      case _NfcSubScreens.readCard:
        return const NfcReadingWidget();
      case _NfcSubScreens.finished:
        return const NfcFinishedWidget();
    }
  }

  onBackButtonClicked() {
    switch (_currentSubScreen) {
      case _NfcSubScreens.welcome:
      case _NfcSubScreens.notValid:
      case _NfcSubScreens.readCard:
      case _NfcSubScreens.finished:
    }

    setState(() {});
  }

  onNextButtonClicked() {
    switch (_currentSubScreen) {
      case _NfcSubScreens.welcome:
      case _NfcSubScreens.notValid:
      case _NfcSubScreens.readCard:
      case _NfcSubScreens.finished:
    }

    setState(() {});
  }
}
