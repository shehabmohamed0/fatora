import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fatora/core/errors/failures/auth/sign_in_with_credential_failure.dart';
import 'package:fatora/core/errors/failures/failures.dart';
import 'package:fatora/core/form_inputs/phone_number.dart';
import 'package:fatora/core/params/auth/verify_phone_params.dart';
import 'package:fatora/features/auth/domain/usecases/verify_phone_number.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'phone_form_state.dart';



@injectable
class PhoneFormCubit extends Cubit<PhoneFormState> {
  PhoneFormCubit(this._verifyPhoneNumber) : super(const PhoneFormState());
  final VerifyPhoneNumber _verifyPhoneNumber;

  void phoneChanged(String value) {
    final phone = PhoneNumber.dirty(value);
    emit(
      state.copyWith(
        phoneNumber: phone,
        status: Formz.validate([phone]),
      ),
    );
  }

  void reset() {
    emit(const PhoneFormState());
  }

  Future<void> verifiy() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final either = await _verifyPhoneNumber(
      params: VerifyPhoneParams(
        phoneNumber: state.phoneNumber.value,
        verificationCompleted: (_) {},
        codeAutoRetrievalTimeout: (_) {},
        codeSent: (verificationId, forceSent) {
          log('Code sent');
          emit(state.copyWith(
            verificationId: verificationId,
            status: FormzStatus.submissionSuccess,
          ));
        },
        verificationFailed: (authException) {
          log(authException.code);
          final failure =
              SignInWithCredentialFailure.fromCode(authException.code);
          emit(
            state.copyWith(
              errorMessage: failure.message,
              status: FormzStatus.submissionFailure,
            ),
          );
        },
      ),
    );
    either.fold((failure) {
      if (failure is ServerFailure) {
        emit(
          state.copyWith(
            errorMessage: failure.message,
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    }, (_) {});
  }
}
