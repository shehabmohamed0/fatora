import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fatora/core/errors/failures/auth/sign_in_with_credential_failure.dart';
import 'package:fatora/core/errors/failures/failures.dart';
import 'package:fatora/core/form_inputs/otp.dart';
import 'package:fatora/core/form_inputs/phone_number.dart';
import 'package:fatora/core/params/auth/phone_sign_in_params.dart';
import 'package:fatora/core/params/auth/verify_phone_params.dart';
import 'package:fatora/features/auth/domain/usecases/sign_in_with_phone.dart';
import 'package:fatora/features/auth/domain/usecases/verify_phone_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'phone_sign_in_state.dart';

@injectable
class PhoneSignInCubit extends Cubit<PhoneSignInState> {
  final VerifyPhoneNumber _verifyPhoneNumber;
  final SignInWithPhone _signInWithPhone;
  PhoneSignInCubit(this._verifyPhoneNumber, this._signInWithPhone)
      : super(const PhoneSignInState());

  void otpChanged(String otp) {
    final newOTP = OTP.dirty(otp);
    emit(state.copyWith(
        otp: OTP.dirty(otp), smsFormStatus: Formz.validate([newOTP])));
  }

  Future<void> _verifiyPhone() async {
    final either = await _verifyPhoneNumber(
        params: VerifyPhoneParams(
      phoneNumber: '+2${state.phoneNumber.value}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        emit(
          state.copyWith(
            otp: OTP.dirty(credential.smsCode),
            autoFilled: true,
          ),
        );
      },
      codeSent: (String verId, forceCodeResent) {
        log('Code sent');
        emit(
          state.copyWith(
            verificationID: verId,
            phoneFormStatus: FormzStatus.submissionSuccess,
            step: state.step + 1,
          ),
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
      codeAutoRetrievalTimeout: (String verId) {},
    ));

    either.fold((failure) {
      if (failure is ServerFailure) {
        emit(
          state.copyWith(
            errorMessage: failure.message,
            phoneFormStatus: FormzStatus.submissionFailure,
          ),
        );
      }
    }, (success) {});
  }

  Future<void> signIn(PhoneAuthCredential phoneAuthCredential) async {
    final failure =
        await _signInWithPhone(params: PhoneSignInParams(phoneAuthCredential));

    failure.fold((failure) {
      if (failure is SignInWithCredentialFailure) {
        emit(
          state.copyWith(
            errorMessage: failure.message,
            smsFormStatus: FormzStatus.submissionFailure,
          ),
        );
      }
    }, (success) {
      emit(state.copyWith(smsFormStatus: FormzStatus.submissionFailure));
    });
  }

  Future<void> submit() async {
    emit(state.copyWith(phoneFormStatus: FormzStatus.submissionInProgress));
    await _verifiyPhone();
  }

  Future<void> submitSMS() async {
    emit(state.copyWith(smsFormStatus: FormzStatus.submissionInProgress));
    final phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: state.verificationID!, smsCode: state.otp.value);
    final either =
        await _signInWithPhone(params: PhoneSignInParams(phoneAuthCredential));

    either.fold((failure) {
      if (failure is SignInWithCredentialFailure) {
        emit(
          state.copyWith(
            errorMessage: failure.message,
            smsFormStatus: FormzStatus.submissionFailure,
          ),
        );
      }
    }, (success) {
      emit(state.copyWith(smsFormStatus: FormzStatus.submissionSuccess));
    });
  }

  phoneChanged(String phone) {
    final newPhone = PhoneNumber.dirty(phone);
    emit(state.copyWith(
        phoneNumber: newPhone, phoneFormStatus: Formz.validate([newPhone])));
  }

  Future<void> onCompleted(String sms) async {
    if (!state.firstFormCompletion) return;
    await submitSMS();
    emit(state.copyWith(firstFormCompletion: false));
  }

  Future<bool> previosStep(BuildContext context) {
    if (state.step == 0) {
      return Future.value(true);
    } else if (state.step == 1) {
      resetOTP();
    }
    emit(state.copyWith(step: state.step - 1));
    return Future.value(false);
  }

  void resetOTP() {
    emit(state.copyWith(
      autoFilled: false,
      firstFormCompletion: true,
      otp: const OTP.pure(),
      verificationID: null,
      smsFormStatus: FormzStatus.pure,
    ));
  }
}
