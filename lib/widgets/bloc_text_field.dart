import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocTextFieldInput<B extends StateStreamable<S>, S>
    extends StatelessWidget {
  final String labelText;
  final String helperText;
  final bool isPassword;
  final TextInputType? keyboaedType;
  final bool Function(S, S)? buildWhen;
  final void Function(B bloc, String text)? onChanged;
  final String? Function(S state)? errorText;
  const BlocTextFieldInput({
    Key? key,
    required this.labelText,
    this.helperText = '',
    required this.errorText,
    this.isPassword = false,
    required this.buildWhen,
    required this.onChanged,
    this.keyboaedType,
  }) : super(key: key);
//(previous, current) => previous.name != current.name
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      buildWhen: buildWhen,
      builder: (context, state) {
        if (isPassword) {
          return _PasswordTextField(
              errorText: errorText?.call(state),
              helperText: '',
              labelText: 'password',
              onChanged: (string) {
                final bloc = context.read<B>();
                onChanged!.call(bloc, string);
              });
        }
        return TextField(
          keyboardType: keyboaedType,
          onChanged: (string) {
            final bloc = context.read<B>();
            onChanged!.call(bloc, string);
          },
          decoration: InputDecoration(
            labelText: labelText,
            helperText: helperText,
            errorText: errorText?.call(state),
          ),
        );
      },
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  final String labelText;
  final String helperText;
  final void Function(String text)? onChanged;
  final String? errorText;
  const _PasswordTextField(
      {Key? key,
      required this.errorText,
      required this.helperText,
      required this.labelText,
      required this.onChanged})
      : super(key: key);

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        helperText: widget.helperText,
        errorText: widget.errorText,
        suffixIcon: InkWell(
          onTap: toggelPassword,
          child: Icon(
            obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
      ),
    );
  }

  void toggelPassword() {
    setState(() => obscureText = !obscureText);
  }
}
