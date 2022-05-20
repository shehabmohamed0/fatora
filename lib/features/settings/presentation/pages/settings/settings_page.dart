
import 'package:fatora/router/routes.dart';
import 'package:flutter/material.dart';

import '../../widgets/settings_list_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SettingsPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 1,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          SettingsListTile(
            title: 'Account Info',
            onTap: () {
              Navigator.of(context).pushNamed(Routes.accountInfo);
            },
          ),
          SettingsListTile(
            title: 'Contact info',
            onTap: () {
              Navigator.of(context).pushNamed(Routes.contactInfo);
            },
          ),
        ],
      ),
    );
  }
}

