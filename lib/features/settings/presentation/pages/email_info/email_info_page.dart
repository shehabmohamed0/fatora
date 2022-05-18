import 'package:fatora/features/auth/presentation/bloc/app_status/app_bloc.dart';
import 'package:fatora/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailInfoPage extends StatelessWidget {
  const EmailInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email info'),
        elevation: 1,
      ),
      body: user.email == null
          ? const _NoEmailWidget()
          : const _EmailInfoWidget(),
    );
  }
}

class _EmailInfoWidget extends StatelessWidget {
  const _EmailInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _NoEmailWidget extends StatelessWidget {
  const _NoEmailWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            'You haven\'t provide email yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.addEmail);
              },
              child: const Text('Add email')),
        )
      ],
    );
  }
}
