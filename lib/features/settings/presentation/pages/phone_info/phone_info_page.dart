import 'package:fatora/core/resources/values_manager.dart';
import 'package:fatora/features/auth/presentation/bloc/app_status/app_bloc.dart';
import 'package:fatora/features/settings/presentation/pages/change_phone/change_phone_page.dart';
import 'package:fatora/router/routes.dart';
import 'package:fatora/widgets/international_phone_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneInfoPage extends HookWidget {
  const PhoneInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Phone info'),
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Column(
            children: [
              InternationalPhoneTextField(
                countries: const ['EG'],
                initialNumber: user.phoneNumber,
                errorText: () => null,
                isEnabled: false,
                onInputChanged: (d) {},
                
              ),
              const SizedBox(height: 8),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.changePhone);
                      },
                      child: const Text('Change')))
            ],
          ),
        ),
      ),
    );
  }
}

class GenderRadio extends StatelessWidget {
  const GenderRadio({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    this.onChanged,
  }) : super(key: key);
  final String title;
  final String value;
  final String? groupValue;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String?>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          visualDensity: VisualDensity.comfortable,
        ),
        Text(title, style: Theme.of(context).textTheme.titleSmall)
      ],
    );
  }
}

class SettingsTextFormField extends StatelessWidget {
  const SettingsTextFormField({
    Key? key,
    this.controller,
    required this.labelText,
    this.onChanged,
    this.initialValue,
    this.suffixIcon,
    this.enabled = true,
  }) : super(key: key);

  final TextEditingController? controller;
  final String labelText;
  final Icon? suffixIcon;
  final String? initialValue;
  final bool enabled;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      enabled: enabled,
      onChanged: onChanged,
      readOnly: !enabled,
      style:
          const TextStyle(fontWeight: FontWeight.w600, fontSize: AppSize.s18),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey.shade400,
          fontWeight: FontWeight.w500,
          fontSize: AppSize.s14,
        ),
      ),
    );
  }
}
