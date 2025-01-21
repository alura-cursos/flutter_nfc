import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/data/local_data_manager.dart';
import 'package:flutter_banco_douro/models/nfc_card.dart';
import 'package:flutter_banco_douro/ui/styles/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc_manager/nfc_manager.dart';

Future<void> showAddNfcCardModal(BuildContext context) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return const _NfcAddModal();
    },
  );
}

class _NfcAddModal extends StatefulWidget {
  const _NfcAddModal();

  @override
  State<_NfcAddModal> createState() => __NfcAddModalState();
}

class __NfcAddModalState extends State<_NfcAddModal> {
  String? idRead;
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    NfcManager.instance.startSession(
      onDiscovered: (tag) async {
        NfcManager.instance.stopSession();
        idRead = tag.data["nfca"]["identifier"].toString();
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.only(
        top: 32,
        left: 16,
        right: 16,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              const Text(
                "Adicionar novo cartão",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Lottie.asset(
                (idRead == null)
                    ? "assets/lotties/nfc_reading.json"
                    : "assets/lotties/nfc_check.json",
                repeat: idRead == null,
                height: 256,
              ),
              Visibility(
                visible: idRead == null,
                child: const Text(
                  "Aproxime seu douradinho",
                  textAlign: TextAlign.center,
                ),
              ),
              TextFormField(
                controller: descController,
                maxLength: 30,
                decoration: const InputDecoration(
                  label: Text("Descrição do cartão"),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              ElevatedButton(
                onPressed: (idRead != null && descController.text != "")
                    ? () {
                        _saveNewCard();
                      }
                    : null,
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColor.orange),
                ),
                child: const Text(
                  "Salvar",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveNewCard() async {
    NfcCard nfcCard = NfcCard(id: idRead!, description: descController.text);
    await LocalDataManager().addNfcCard(nfcCard);

    if (!mounted) return;
    Navigator.pop(context);
  }
}
