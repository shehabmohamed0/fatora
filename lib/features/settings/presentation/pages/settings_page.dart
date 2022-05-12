import 'package:fatora/features/auth/presentation/bloc/app_status/app_bloc.dart';
import 'package:fatora/router/routes.dart';
import 'package:fatora/widgets/avatar.dart';
import 'package:flutter/material.dart';

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
            title: 'Saved addresses',
            onTap: () {
              Navigator.of(context).pushNamed(Routes.accountInfo);
            },
          ),
          SettingsListTile(
            title: 'Login methods',
            onTap: () {
              Navigator.of(context).pushNamed(Routes.accountInfo);
            },
          ),
        ],
      ),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: const Icon(
        Icons.arrow_forward_ios_outlined,
        size: 20,
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w600),
      ),
      onTap: onTap,
    );
  }
}
