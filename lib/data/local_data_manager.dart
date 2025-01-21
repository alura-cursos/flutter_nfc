import 'package:flutter_banco_douro/helpers/prefs_keys.dart';
import 'package:flutter_banco_douro/models/nfc_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataManager {
  Future<void> saveIsFirstTime(bool isFirstTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefsKeys.isFirstTime, isFirstTime);
  }

  Future<bool> readIsFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefsKeys.isFirstTime) ?? true;
  }

  Future<void> addNfcCard(NfcCard nfcCard) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lê o cartão principal
    String? currentDefaultNfcCard = prefs.getString(PrefsKeys.defaultCard);

    if (currentDefaultNfcCard == null) {
      // Se não há cartão principal, salva como principal
      await prefs.setString(PrefsKeys.defaultCard, nfcCard.toJson());
    } else {
      // Se há, lê os outros cartões
      List<String>? listOthers = prefs.getStringList(PrefsKeys.listOtherCards);

      if (listOthers == null) {
        // Se não há outros cartões, adiciona uma lista contendo
        await prefs.setStringList(
          PrefsKeys.listOtherCards,
          [nfcCard.toJson()],
        );
      } else {
        // Se há, adiciona na lista que já existe
        listOthers.add(nfcCard.toJson());
        await prefs.setStringList(PrefsKeys.listOtherCards, listOthers);
      }
    }
  }

  Future<List<NfcCard>> getAllNfcCard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<NfcCard> listNfcCards = [];

    // Lê o cartão principal
    String? currentDefaultNfcCard = prefs.getString(PrefsKeys.defaultCard);
    if (currentDefaultNfcCard != null) {
      // Se há um cartão principal, ele será o primeiro a lista
      listNfcCards.add(NfcCard.fromJson(currentDefaultNfcCard));

      // Lê e adiciona os demais cartões
      List<String>? listOthers = prefs.getStringList(PrefsKeys.listOtherCards);
      if (listOthers != null) {
        for (String jsonElement in listOthers) {
          listNfcCards.add(NfcCard.fromJson(jsonElement));
        }
      }
    }

    // Retorna a lista
    return listNfcCards;
  }

  Future<void> removeNfcCard(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lê a lista de outros cartões (o cartão principal não pode ser removido)
    List<String>? listOtherCardsJson =
        prefs.getStringList(PrefsKeys.listOtherCards);
    if (listOtherCardsJson != null) {
      // Se a lista não for nula, converte em uma lista do objeto
      List<NfcCard> listCards =
          listOtherCardsJson.map((e) => NfcCard.fromJson(e)).toList();

      // Remove da lista
      listCards.removeWhere((element) => element.id == id);

      // Converte de volta para JSON e salva
      listOtherCardsJson = listCards.map((e) => e.toJson()).toList();
      await prefs.setStringList(PrefsKeys.listOtherCards, listOtherCardsJson);
    }
  }

  Future<void> makePrimaryNfcCard(NfcCard nfcCard) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lê o cartão principal
    String? currentDefaultNfcCard = prefs.getString(PrefsKeys.defaultCard);
    if (currentDefaultNfcCard != null) {
      // Se houver, lê a lista dos outros cartões
      List<String>? listOtherCardsJson =
          prefs.getStringList(PrefsKeys.listOtherCards);

      if (listOtherCardsJson != null) {
        // Se houver, converte para uma lista do objeto para manipulação
        List<NfcCard> listCards =
            listOtherCardsJson.map((e) => NfcCard.fromJson(e)).toList();

        // Adiciona o cartão que era o principal
        listCards.add(NfcCard.fromJson(currentDefaultNfcCard));

        // Faz o cartão recebido por parâmetro ser o principal
        await prefs.setString(PrefsKeys.defaultCard, nfcCard.toJson());

        // Remove o cartão recebido por parâmetro
        listCards.removeWhere((element) => element.id == nfcCard.id);

        // Converte a lista de volta para JSON e salva
        listOtherCardsJson = listCards.map((e) => e.toJson()).toList();
        await prefs.setStringList(PrefsKeys.listOtherCards, listOtherCardsJson);
      }
    }
  }
}
