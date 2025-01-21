import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/data/local_data_manager.dart';
import 'package:flutter_banco_douro/models/nfc_card.dart';
import 'package:flutter_banco_douro/ui/components/add_nfc_card_modal.dart';
import 'package:nfc_manager/nfc_manager.dart';

import 'styles/colors.dart';
import 'widgets/nfc_card_list_widget.dart';

class NfcSettingsScreen extends StatefulWidget {
  const NfcSettingsScreen({super.key});

  @override
  State<NfcSettingsScreen> createState() => _NfcSettingsScreenState();
}

class _NfcSettingsScreenState extends State<NfcSettingsScreen> {
  List<NfcCard> listCards = [];

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerenciar cartões NFC"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.orange,
        onPressed: () {
          _showAddNfcCard();
        },
        child: const Icon(
          Icons.credit_card,
          color: Colors.black,
        ),
      ),
      body: ListView.builder(
        itemCount: listCards.length,
        itemBuilder: (context, index) {
          NfcCard nfcCard = listCards[index];
          return NfcCardsListWidget(
            nfcCard: nfcCard,
            index: index,
            onMakePrimaryClicked: _onMakePrimaryClicked,
            onRemoveClicked: _onRemoveClicked,
          );
        },
      ),
    );
  }

  _refresh() async {
    List<NfcCard> listTemp = await LocalDataManager().getAllNfcCard();
    setState(() {
      listCards = listTemp;
    });
  }

  _showAddNfcCard() async {
    await showAddNfcCardModal(context);
    await NfcManager.instance.stopSession();
    _refresh();
  }

  _onMakePrimaryClicked(NfcCard nfcCard) async {
    await LocalDataManager().makePrimaryNfcCard(nfcCard);
    _refresh();
  }

  _onRemoveClicked(NfcCard nfcCard) async {
    await LocalDataManager().removeNfcCard(nfcCard.id);
    _refresh();
  }
}
