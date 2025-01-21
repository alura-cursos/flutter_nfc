import 'package:flutter/material.dart';

import '../../models/nfc_card.dart';
import '../styles/colors.dart';

class NfcCardsListWidget extends StatelessWidget {
  final NfcCard nfcCard;
  final int index;

  final Function(NfcCard nfcCard) onMakePrimaryClicked;
  final Function(NfcCard nfcCard) onRemoveClicked;

  const NfcCardsListWidget({
    super.key,
    required this.nfcCard,
    required this.index,
    required this.onMakePrimaryClicked,
    required this.onRemoveClicked,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.credit_card,
        size: 32,
        color: (index == 0) ? AppColor.orange : null,
      ),
      title: Text(
        nfcCard.description,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: (index == 0)
          ? const Text(
              "PRINCIPAL",
              style: TextStyle(
                fontSize: 10,
                color: AppColor.orange,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
      trailing: (index == 0)
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    onMakePrimaryClicked(nfcCard);
                  },
                  tooltip: "Tornar principal",
                  icon: const Icon(Icons.credit_score),
                ),
                IconButton(
                  onPressed: () {
                    onRemoveClicked(nfcCard);
                  },
                  tooltip: "Remover",
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red[900],
                  ),
                ),
              ],
            ),
    );
  }
}
