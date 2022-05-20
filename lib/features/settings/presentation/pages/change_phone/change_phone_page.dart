import 'package:fatora/core/form_inputs/phone_number.dart';
import 'package:fatora/core/resources/values_manager.dart';
import 'package:fatora/features/auth/presentation/bloc/app_status/app_bloc.dart';
import 'package:fatora/features/settings/presentation/bloc/change_phone/update_phone_cubit.dart';
import 'package:fatora/features/settings/presentation/pages/change_phone/otp_page.dart';
import 'package:fatora/locator/locator.dart';
import 'package:fatora/widgets/international_phone_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';

class ChangePhonePage extends HookWidget {
  const ChangePhonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final textController = useTextEditingController();
    return BlocProvider<UpdateePhoneCubit>(
      create: (context) => locator(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Change phone number'),
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        body: BlocConsumer<UpdateePhoneCubit, UpdatePhoneState>(
          listenWhen: (previous, current) =>
              previous.phoneNumber != current.phoneNumber ||
              previous.phoneFormStatus != current.phoneFormStatus,
          listener: (context, state) {
            if (state.phoneFormStatus.isSubmissionSuccess) {
              _navigateToOtpPage(context);
            } else if (state.phoneFormStatus.isSubmissionFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                      content:
                          Text(state.errorMessage ?? 'Change number failure')),
                );
            }
          },
          buildWhen: (previous, current) {
            return previous.phoneNumber != current.phoneNumber ||
                previous.phoneFormStatus != current.phoneFormStatus;
          },
          builder: (context, state) {
            return ListView(children: [
              if (state.phoneFormStatus.isSubmissionInProgress)
                const LinearProgressIndicator(),
            Padding(
                  padding: const EdgeInsets.all(AppPadding.p16),
                  child: Column(children: [
                    InternationalPhoneTextField(
                      controller: textController,
                      countries: const ['EG'],
                      errorText: () {
                        return state.phoneNumber
                            .validationMessageWithOldPhone(user.phoneNumber);
                      },
                      onInputChanged: (phoneNumber) {
                        context
                            .read<UpdateePhoneCubit>()
                            .phoneChanged(phoneNumber.phoneNumber!);
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                        height: 46,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: state.phoneFormStatus.isValid &&
                                        state.phoneNumber.value !=
                                            user.phoneNumber ||
                                    state.phoneFormStatus.isSubmissionFailure
                                ? context.read<UpdateePhoneCubit>().verifiyPhone
                                : null,
                            child: const Text('Submit'))),
                  ])),
            ]);
          },
        ),
      ),
    );
  }

  Future<T?> _navigateToOtpPage<T extends Object?>(BuildContext context) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider<UpdateePhoneCubit>.value(
          value: context.read<UpdateePhoneCubit>(),
          child: const OTPPage(),
        ),
      ),
    );
  }
}
