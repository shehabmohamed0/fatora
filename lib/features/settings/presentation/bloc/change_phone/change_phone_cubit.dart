import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fatora/core/form_inputs/phone_number.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'change_phone_state.dart';

@injectable
class ChangePhoneCubit extends Cubit<ChangePhoneState> {
  ChangePhoneCubit() : super(const ChangePhoneState());

  void phoneChanged(String phoneNumber) {
    final newPhone = PhoneNumber.dirty(phoneNumber);
    emit(state.copyWith(
      phoneNumber: newPhone,
      status: Formz.validate([newPhone])
    ));
  }
}
