import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class InternationalPhoneTextField extends StatelessWidget {
  const InternationalPhoneTextField(
      {Key? key,
      this.controller,
      this.hintText,
      this.initialNumber,
      this.errorText,
      this.countries,
      required this.onInputChanged,
      this.isEnabled})
      : super(key: key);
  final TextEditingController? controller;
  final String? hintText;
  final String? initialNumber;
  final String? Function()? errorText;
  final List<String>? countries;
  final bool? isEnabled;
  final void Function(PhoneNumber)? onInputChanged;
  @override
  Widget build(BuildContext context) {
    if (initialNumber != null) {
      return FutureBuilder<PhoneNumber>(
        future: PhoneNumber.getRegionInfoFromPhoneNumber(initialNumber!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return InternationalPhoneNumberInput(
              initialValue: snapshot.data,
              textFieldController: controller,
              hintText: hintText,
              inputDecoration: InputDecoration(errorText: errorText?.call()),
              onInputChanged: onInputChanged,
              keyboardType: TextInputType.number,
              spaceBetweenSelectorAndTextField: 8,
              selectorConfig: const SelectorConfig(
                setSelectorButtonAsPrefixIcon: true,
                leadingPadding: 16,
              ),
              formatInput: true,
              isEnabled: isEnabled ?? true,
              selectorTextStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              countries: countries,
            );
          } else {
            return Container();
          }
        },
      );
    }
    return InternationalPhoneNumberInput(
      textFieldController: controller,
      hintText: hintText,
      inputDecoration: InputDecoration(errorText: errorText?.call()),
      onInputChanged: onInputChanged,
      keyboardType: TextInputType.number,
      spaceBetweenSelectorAndTextField: 8,
      selectorConfig: const SelectorConfig(
        setSelectorButtonAsPrefixIcon: true,
        leadingPadding: 16,
      ),
      formatInput: true,
      isEnabled: isEnabled ?? true,
      selectorTextStyle:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      countries: countries,
    );
  }
}
