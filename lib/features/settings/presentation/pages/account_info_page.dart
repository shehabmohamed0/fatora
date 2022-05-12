import 'package:fatora/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class AccountInfoPage extends StatelessWidget {
  const AccountInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingTextFormField(
              labelText: 'Name',
              initialValue: 'Shehab mohamed',
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                showDatePicker(
                    context: context,
                    firstDate: DateTime.utc(2000),
                    initialDate: DateTime.now(),
                    lastDate: DateTime.now());
              },
              child: const SettingTextFormField(
                enabled: false,
                labelText: 'Date of birth',
                suffixIcon: Icon(Icons.calendar_today_outlined),
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
                  groupValue: 'male',
                  onChanged: (val) {},
                ),
                const SizedBox(width: 8),
                GenderRadio(
                  title: 'Female',
                  value: 'female',
                  groupValue: 'female',
                  onChanged: (val) {},
                ),
                GenderRadio(
                  title: 'Not speified',
                  value: 'female',
                  groupValue: 'female',
                  onChanged: (val) {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class GenderRadio extends StatelessWidget {
  const GenderRadio({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);
  final String title;
  final String value;
  final String groupValue;
  final void Function(String?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
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

class SettingTextFormField extends StatelessWidget {
  const SettingTextFormField({
    Key? key,
    this.controller,
    required this.labelText,
    this.initialValue,
    this.suffixIcon,
    this.enabled = true,
  }) : super(key: key);

  final TextEditingController? controller;
  final String labelText;
  final Icon? suffixIcon;
  final String? initialValue;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      enabled: enabled,
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
