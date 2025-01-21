import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Gerenciar cartões NFC"),
            onTap: () {
              Navigator.pushNamed(context, "nfc_settings");
            },
          ),
        ],
      ),
    );
  }
}
