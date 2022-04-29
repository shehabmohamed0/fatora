import 'package:fatora/bloc_observer.dart';
import 'package:fatora/features/auth/domain/repositories/auth_repository.dart';
import 'package:fatora/features/auth/presentation/bloc/app_status/app_bloc.dart';
import 'package:fatora/locator/locator.dart';
import 'package:fatora/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
     await configureDependencies();
      final AuthRepository authRepository = locator();
      await authRepository.user.first;
      runApp(App(
        authRepository: locator(),
      ));
    },
    blocObserver: AppBlocObserver(),
  );
}

class App extends StatelessWidget {
  final AuthRepository authRepository;

  const App({Key? key, required this.authRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBloc(authRepository: authRepository),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
