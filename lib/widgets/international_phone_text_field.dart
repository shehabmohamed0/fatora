import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class InternationalPhoneTextField extends StatelessWidget {
  const InternationalPhoneTextField(
      {Key? key,
      this.hintText,
      this.initialNumber,
      required this.errorText,
      this.countries,
      required this.onInputChanged,
      this.isEnabled})
      : super(key: key);
  final String? hintText;
  final String? initialNumber;
  final String? Function() errorText;
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
              hintText: hintText,
              onInputChanged: onInputChanged,
              initialValue: snapshot.data,
              spaceBetweenSelectorAndTextField: 8,
              formatInput: true,
              isEnabled: isEnabled ?? true,
              searchBoxDecoration:
                  const InputDecoration(border: OutlineInputBorder()),
              inputDecoration: InputDecoration(
                border: const OutlineInputBorder(),
                errorText: errorText.call(),
              ),
              selectorTextStyle: const TextStyle(fontWeight: FontWeight.bold),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
              countries:countries,
            );
          } else {
            return Container();
          }
        },
      );
    }
    return InternationalPhoneNumberInput(
      hintText: hintText,
      onInputChanged: onInputChanged,
      spaceBetweenSelectorAndTextField: 8,
      searchBoxDecoration: const InputDecoration(border: OutlineInputBorder()),
      inputDecoration: InputDecoration(
        border: const OutlineInputBorder(),
        errorText: errorText.call(),
      ),
      selectorTextStyle: const TextStyle(fontWeight: FontWeight.bold),
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      countries: countries,
    );
  }
}
