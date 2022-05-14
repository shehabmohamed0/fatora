import 'package:fatora/features/auth/presentation/bloc/app_status/app_bloc.dart';
import 'package:fatora/router/routes.dart';
import 'package:fatora/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        leading: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Avatar(
              photo: user.photoURL,
              onTap: () {
                Navigator.pushNamed(context, Routes.settings);
              },
            ),
          ),
        ),
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          )
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Avatar(photo: user.photoURL),
            const SizedBox(height: 4),
            Text(user.email ?? '', style: textTheme.headline6),
            const SizedBox(height: 4),
            Text(user.name, style: textTheme.headline5),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
