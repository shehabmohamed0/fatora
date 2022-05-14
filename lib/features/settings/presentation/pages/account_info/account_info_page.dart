import 'package:fatora/core/resources/values_manager.dart';
import 'package:fatora/features/auth/presentation/bloc/app_status/app_bloc.dart';
import 'package:fatora/features/settings/presentation/bloc/account_info/account_info_cubit.dart';
import 'package:fatora/features/settings/presentation/pages/phone_info/phone_info_page.dart';
import 'package:fatora/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

class AccountInfoPage extends HookWidget {
  const AccountInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final controller = useTextEditingController(
      text: user.birthDate != null
          ? DateFormat.yMd().format(DateTime.now()).toString()
          : null,
    );
    return BlocProvider<AccountInfoCubit>(
      create: (context) => locator()..initialize(user),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Account info'),
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: BlocConsumer<AccountInfoCubit, AccountInfoState>(
            listener: (context, state) {
              if (state.status.isSubmissionInProgress) {
                EasyLoading.show(
                    status: 'loading...',
                    indicator: const FittedBox(
                      child: SpinKitRipple(
                        duration: Duration(milliseconds: 1200),
                        color: Colors.white,
                      ),
                    ));
              } else if (state.status.isSubmissionFailure) {
                EasyLoading.dismiss();
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                      SnackBar(content: Text(state.errorMessage ?? 'failure')));
              } else if (state.status.isSubmissionSuccess) {
                EasyLoading.dismiss();
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingsTextFormField(
                    labelText: 'Name',
                    initialValue: state.name.value,
                    onChanged: context.read<AccountInfoCubit>().nameChanged,
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () async {
                      final birthDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.utc(2000),
                          initialDate: DateTime.now(),
                          lastDate: DateTime.now());

                      if (birthDate != null) {
                        context
                            .read<AccountInfoCubit>()
                            .birthDateChanged(birthDate, controller);
                      }
                    },
                    child: SettingsTextFormField(
                      controller: controller,
                      enabled: false,
                      labelText: 'Date of birth',
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Gender (optional)',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.grey.shade400),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      GenderRadio(
                        title: 'Male',
                        value: 'male',
                        groupValue: state.gender,
                        onChanged:
                            context.read<AccountInfoCubit>().genderChanged,
                      ),
                      const SizedBox(width: 8),
                      GenderRadio(
                        title: 'Female',
                        value: 'female',
                        groupValue: state.gender,
                        onChanged:
                            context.read<AccountInfoCubit>().genderChanged,
                      ),
                      GenderRadio(
                        title: 'Not specified',
                        value: '',
                        groupValue: state.gender,
                        onChanged:
                            context.read<AccountInfoCubit>().genderChanged,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.status.isSubmissionInProgress
                          ? null
                          : context.read<AccountInfoCubit>().updateProfile,
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        )),
      ),
    );
  }
}



