import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/data/local_data_manager.dart';
import 'package:flutter_banco_douro/ui/components/dialogs.dart';
import 'package:flutter_banco_douro/ui/widgets/nfc_reading_widget.dart';
import 'package:flutter_banco_douro/ui/widgets/nfc_start_read_widget.dart';
import 'package:nfc_manager/nfc_manager.dart';

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
    NfcManager.instance.startSession(
      onDiscovered: (tag) async {
        await NfcManager.instance.stopSession();

        String id = tag.data["nfca"]["identifier"].toString();
        String savedId = (await LocalDataManager().readTagId())!;

        if (id == savedId) {
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, "home");
        } else {
          showWrongCardDialog();
        }
      },
    );
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
    await LocalDataManager().saveIsFirstTime(true);
    await NfcManager.instance.stopSession();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, "login");
  }
}
