import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(errorMessage),
      ),
    );
}
