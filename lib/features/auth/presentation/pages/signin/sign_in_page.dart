import 'package:dartz/dartz.dart';
import 'package:fatora/core/form_inputs/email.dart';
import 'package:fatora/core/form_inputs/password.dart';
import 'package:fatora/core/form_inputs/phone_number.dart';
import 'package:fatora/core/resources/assets_manager.dart';
import 'package:fatora/core/resources/constants_manager.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_in/email_form/email_form_cubit.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_in/login_form_selection/login_form_selection_cubit.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_in/phone_form/phone_form_cubit.dart';
import 'package:fatora/features/auth/presentation/bloc/verifiy_phone/verifiy_phone_cubit.dart';
import 'package:fatora/features/auth/presentation/pages/signin/widgets/toggle_buttons.dart';
import 'package:fatora/features/auth/presentation/pages/verifiy_phone/verifiy_phone_page.dart';
import 'package:fatora/locator/locator.dart';
import 'package:fatora/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';

import '../../../../../widgets/international_phone_text_field.dart';
import '../../../../../widgets/password_text_field.dart';

part 'widgets/email_sign_in_form.dart';
part 'widgets/phone_sign_in_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SignInPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Login Account',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 32),
                LayoutBuilder(
                  builder: (context, constrains) {
                    return ToggleButton(
                      width: constrains.maxWidth,
                      height: 50.0,
                      toggleBackgroundColor: const Color(0xffF6F5FA),
                      toggleBorderColor: Colors.grey[350]!,
                      toggleColor: Colors.white,
                      inActiveTextColor: Colors.grey,
                      activeTextColor: Colors.black54,
                      leftDescription: 'Email',
                      rightDescription: 'Phone number',
                      onLeftToggleActive: () {
                        context
                            .read<LoginFormSelectionCubit>()
                            .showEmaileForm();
                        context.read<PhoneFormCubit>().reset();
                      },
                      onRightToggleActive: () {
                        context.read<LoginFormSelectionCubit>().showPhoneForm();
                        context.read<EmailFormCubit>().reset();
                      },
                    );
                  },
                ),
                BlocConsumer<LoginFormSelectionCubit, LoginFormSelectionState>(
                  listener: (context, state) {
                    if (state is LoginFormEmail) {
                    } else if (state is LoginFormPhone) {}
                  },
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: AppConstants.duration200ms,
                      child: state is LoginFormPhone
                          ? const SizedBox(
                              key: Key('1'),
                              height: 400,
                              child: PhoneSignInForm(),
                            )
                          : const SizedBox(
                              key: Key('2'),
                              height: 400,
                              child: EmailSignInForm(),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
 // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Expanded(
                //         child: Divider(
                //       thickness: 1,
                //       color: Colors.black,
                //     )),
                //     const SizedBox(width: 4),
                //     Text(
                //       'or sign in with Google',
                //       style: Theme.of(context).textTheme.bodySmall,
                //     ),
                //     const SizedBox(width: 4),
                //     const Expanded(
                //         child: Divider(
                //       thickness: 1,
                //       color: Colors.black,
                //     )),
                //   ],
                // ),
                // const SizedBox(height: 32),