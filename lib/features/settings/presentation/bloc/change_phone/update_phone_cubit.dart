import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fatora/core/errors/failures/auth/sign_in_with_credential_failure.dart';
import 'package:fatora/core/errors/failures/failures.dart';
import 'package:fatora/core/errors/failures/settings/update_phone_number_failure.dart';
import 'package:fatora/core/form_inputs/otp.dart';
import 'package:fatora/core/form_inputs/phone_number.dart';
import 'package:fatora/core/params/auth/verify_phone_params.dart';
import 'package:fatora/core/params/settings/update_phone_params.dart';
import 'package:fatora/features/auth/domain/usecases/verify_phone_number.dart';
import 'package:fatora/features/settings/domain/usecases/update_phone_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'update_phone_state.dart';

@injectable
class UpdateePhoneCubit extends Cubit<UpdatePhoneState> {
  final VerifyPhoneNumber _verifyPhoneNumber;
  final UpdatePhoneNumber _updatePhoneNumber;
  UpdateePhoneCubit(this._verifyPhoneNumber, this._updatePhoneNumber)
      : super(const UpdatePhoneState());

  void phoneChanged(String phoneNumber) {
    final newPhone = PhoneNumber.dirty(phoneNumber);
    log(phoneNumber);
    emit(state.copyWith(
        phoneNumber: newPhone, phoneFormStatus: Formz.validate([newPhone])));
  }

  Future<void> verifiyPhone() async {
    emit(state.copyWith(phoneFormStatus: FormzStatus.submissionInProgress));
    final either = await _verifyPhoneNumber(
      params: VerifyPhoneParams(
        phoneNumber: state.phoneNumber.value,
        verificationCompleted: (phoneAuthCredential) async {
          final newOTP = OTP.dirty(phoneAuthCredential.smsCode);
          emit(
            state.copyWith(
                phoneAuthCredential: phoneAuthCredential,
                otp: newOTP,
                otpFormStatus: Formz.validate([newOTP])),
          );
        },
        verificationFailed: (authException) {
          log(authException.code);
          final failure =
              SignInWithCredentialFailure.fromCode(authException.code);
          emit(
            state.copyWith(
              errorMessage: failure.message,
              phoneFormStatus: FormzStatus.submissionFailure,
            ),
          );
        },
        codeSent: (verficationId, ints) {
          emit(
            state.copyWith(
              verificationId: verficationId,
              phoneFormStatus: FormzStatus.submissionSuccess,
            ),
          );
          emit(
            state.copyWith(phoneFormStatus: FormzStatus.valid),
          );
        },
        codeAutoRetrievalTimeout: (verId) {},
      ),
    );

    either.fold((failure) {
      if (failure is ServerFailure) {
        emit(state.copyWith(
          errorMessage: failure.message,
          phoneFormStatus: FormzStatus.submissionFailure,
        ));
      }
      if (failure is ServerFailure) {
        emit(state.copyWith(
          errorMessage: failure.message,
          phoneFormStatus: FormzStatus.submissionFailure,
        ));
      }
    }, (_) {});
  }

  void otpChanged(String otp) {
    final newOTP = OTP.dirty(otp);
    emit(state.copyWith(
        otp: OTP.dirty(otp), otpFormStatus: Formz.validate([newOTP])));
  }

  Future<void> updatePhoneNumber(PhoneAuthCredential phoneCredential) async {
    emit(state.copyWith(otpFormStatus: FormzStatus.submissionInProgress));
    final either = await _updatePhoneNumber(
        params: UpdatePhoneNumberParams(
      phoneNumber: state.phoneNumber.value,
      phoneCredential: phoneCredential,
    ));

    either.fold((failure) {
      if (failure is UpdatePhoneNumberFailure) {
        emit(state.copyWith(
          errorMessage: failure.message,
          otpFormStatus: FormzStatus.submissionFailure,
        ));
      }
    }, (success) {
      emit(state.copyWith(otpFormStatus: FormzStatus.submissionSuccess));
    });
  }

  void onCompleted(String completedOTP) async {
    late final PhoneAuthCredential phoneCredential;
    if (state.autoRetrievedSMS) {
      phoneCredential = state.phoneAuthCredential!;
    } else {
      phoneCredential = PhoneAuthProvider.credential(
          verificationId: state.verificationId, smsCode: completedOTP);
    }

    await updatePhoneNumber(phoneCredential);
  }

  void onCompletedOneTime(String completedOTP) {
    if (!state.otpFormCompletedOneTime) {
      emit(state.copyWith(otpFormCompletedOneTime: true));
      onCompleted(completedOTP);
    }
  }

  Future<void> complete() async {
    late final PhoneAuthCredential phoneCredential;
    if (state.autoRetrievedSMS) {
      phoneCredential = state.phoneAuthCredential!;
    } else {
      phoneCredential = PhoneAuthProvider.credential(
          verificationId: state.verificationId, smsCode: state.otp.value);
    }

    await updatePhoneNumber(phoneCredential);
  }

  void resetOtpData() {
    emit(state.copyWith(phoneFormStatus: FormzStatus.valid));
  }
}
