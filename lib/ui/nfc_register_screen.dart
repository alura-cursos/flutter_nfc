import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/data/local_data_manager.dart';
import 'package:flutter_banco_douro/models/nfc_card.dart';
import 'package:flutter_banco_douro/ui/styles/colors.dart';
import 'package:flutter_banco_douro/ui/widgets/nfc_finished_widget.dart';
import 'package:flutter_banco_douro/ui/widgets/nfc_not_valid.dart';
import 'package:flutter_banco_douro/ui/widgets/nfc_reading_widget.dart';
import 'package:nfc_manager/nfc_manager.dart';
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
  _NfcSubScreens _currentSubScreen = _NfcSubScreens.welcome;
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
        Navigator.pushReplacementNamed(context, "login");
        break;
    }

    setState(() {});
  }

  onNextButtonClicked() async {
    switch (_currentSubScreen) {
      case _NfcSubScreens.welcome:
        verifyNfcAvailable().then(
          (bool isAvailable) {
            if (isAvailable) {
              startReading();
              _currentSubScreen = _NfcSubScreens.readCard;
            } else {
              _currentSubScreen = _NfcSubScreens.notValid;
            }
          },
        );
      case _NfcSubScreens.readCard:
        break;
      case _NfcSubScreens.notValid:
        await LocalDataManager().saveIsFirstTime(false);
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, "home");
        break;
      case _NfcSubScreens.finished:
        Navigator.pushReplacementNamed(context, "home");
        break;
    }

    setState(() {});
  }

  Future<bool> verifyNfcAvailable() async {
    NfcManager nfcManager = NfcManager.instance;
    return nfcManager.isAvailable();
  }

  Future<void> startReading() async {
    setState(() {
      isReadingNfc = true;
    });
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        await NfcManager.instance.stopSession();

        NfcCard nfcCard = NfcCard(
          id: tag.data["nfca"]["identifier"].toString(),
          description: "Primeiro registro",
        );

        await LocalDataManager().addNfcCard(nfcCard);

        await LocalDataManager().saveIsFirstTime(false);

        setState(() {
          isReadingNfc = false;
          _currentSubScreen = _NfcSubScreens.finished;
        });
      },
    );
  }
}
