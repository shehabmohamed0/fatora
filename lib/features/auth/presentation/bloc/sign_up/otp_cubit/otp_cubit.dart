import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:fatora/core/errors/failures/auth/sign_in_with_credential_failure.dart';
import 'package:fatora/core/errors/failures/failures.dart';
import 'package:fatora/core/params/auth/phone_sign_up_params.dart';
import 'package:fatora/core/params/auth/verify_phone_params.dart';
import 'package:fatora/features/auth/domain/usecases/phone_sign_up.dart';
import 'package:fatora/features/auth/domain/usecases/verify_phone_number.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/flow_cubit/sign_up_flow_cubit.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/sign_up_form/sign_up_form_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/form_inputs/otp.dart';

part 'otp_state.dart';

@injectable
class OTPCubit extends Cubit<OTPState> {
  final VerifyPhoneNumber _verifyPhoneNumber;
  final PhoneSignUp _phoneSignUp;
  OTPCubit({
    required VerifyPhoneNumber verifyPhoneNumber,
    required PhoneSignUp phoneSignUp,
  })  : _verifyPhoneNumber = verifyPhoneNumber,
        _phoneSignUp = phoneSignUp,
        super(const OTPState());

  void otpChanged(String otp) {
    final newOTP = OTP.dirty(otp);
    emit(state.copyWith(otp: OTP.dirty(otp), status: Formz.validate([newOTP])));
  }

  Future<void> resend() async {}

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context) async {
    final either = await _verifyPhoneNumber.call(
        params: VerifyPhoneParams(
      phoneNumber: '+2$phoneNumber',
      verificationCompleted: (PhoneAuthCredential authCredential) {
        emit(state.copyWith(
          otp: OTP.dirty(authCredential.smsCode),
          autoGetCode: true,
          status: FormzStatus.submissionSuccess,
        ));
      },
      verificationFailed: (authException) {
        final failure =
            SignInWithCredentialFailure.fromCode(authException.code);
        log(authException.code);
        context.read<SignUpFormCubit>().submissionFailure(failure);
      },
      codeSent: (String verId, forceCodeResent) {
        emit(state.copyWith(verificationId: verId));
        context.read<SignUpFormCubit>().resetSubmissition();
        context.read<SignUpFlowCubit>().nextStep();
      },
      codeAutoRetrievalTimeout: (String verId) {},
    ));

    either.fold((failure) {
      context.read<SignUpFormCubit>().submissionFailure(failure);

      if (failure is ServerFailure) {}
    }, (success) {});
  }

  Future<void> onCompleted(String smsCode, BuildContext context) async {
    if (state.autoVerified) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId, smsCode: smsCode);
    final signUpSate = context.read<SignUpFormCubit>().state;
    final either = await _phoneSignUp(
        params: PhoneSignUpParams(
            name: signUpSate.name.value,
            phoneNumber: signUpSate.phoneNumber.value,
            phoneCredential: credential));

    either.fold((failure) {
      if (failure is SignInWithCredentialFailure) {
        emit(state.copyWith(
            errorMessage: failure.message,
            status: FormzStatus.submissionFailure));
      }
    }, (success) {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));

      context.read<SignUpFlowCubit>().nextStep();
    });
    emit(state.copyWith(autoVerified: true));
  }

  void reset() {
    emit(const OTPState());
  }

  Future<void> submit(BuildContext context) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId, smsCode: state.otp.value);
    final signUpSate = context.read<SignUpFormCubit>().state;
    final either = await _phoneSignUp(
        params: PhoneSignUpParams(
            name: signUpSate.name.value,
            phoneNumber: signUpSate.phoneNumber.value,
            phoneCredential: credential));

    either.fold((failure) {
      if (failure is SignInWithCredentialFailure) {
        emit(state.copyWith(
            errorMessage: failure.message,
            status: FormzStatus.submissionFailure));
      }
    }, (success) {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));

      context.read<SignUpFlowCubit>().nextStep();
    });
  }

  void autoFillPinput(TextEditingController textEditingController, String sms) {
    textEditingController.text = sms;
    emit(state.copyWith(otp: OTP.dirty(sms)));
  }
}
