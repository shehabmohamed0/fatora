import 'dart:developer';

import 'package:fatora/core/form_inputs/phone_number.dart';
import 'package:fatora/core/resources/values_manager.dart';
import 'package:fatora/features/settings/presentation/bloc/change_phone/change_phone_cubit.dart';
import 'package:fatora/locator/locator.dart';
import 'package:fatora/widgets/international_phone_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePhonePage extends StatelessWidget {
  const ChangePhonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePhoneCubit>(
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: BlocConsumer<ChangePhoneCubit, ChangePhoneState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Column(
                  children: [
                    InternationalPhoneTextField(
                      countries: const ['Eg'],
                      errorText: state.phoneNumber.validationMessage,
                      onInputChanged: (phoneNumber) {
                        context
                            .read<ChangePhoneCubit>()
                            .phoneChanged(phoneNumber.phoneNumber!);
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                        height: 46,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text('Change'))),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
