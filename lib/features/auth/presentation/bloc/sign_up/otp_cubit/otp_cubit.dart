import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    await _verifyPhoneNumber.call(
        params: VerifyPhoneParams(
      phoneNumber: '+2$phoneNumber',
      verificationCompleted: (PhoneAuthCredential authCredential) {
        emit(state.copyWith(
          otp: OTP.dirty(authCredential.smsCode),
          authCredential: authCredential,
          status: FormzStatus.submissionSuccess,
        ));
      },
      verificationFailed: (authException) {
        log(authException.code);
      },
      codeSent: (String verId, forceCodeResent) {
        emit(state.copyWith(verificationId: verId));
        context.read<SignUpFlowCubit>().nextStep();
      },
      codeAutoRetrievalTimeout: (String verId) {},
    ));
  }

  Future<void> onCompleted(String smsCode, BuildContext context) async {
    if (state.autoVerified) return;
    final credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId, smsCode: smsCode);
    final signUpSate = context.read<SignUpFormCubit>().state;
    final either = await _phoneSignUp(
        params: PhoneSignUpParams(
            name: signUpSate.name.value,
            phoneNumber: signUpSate.phoneNumber.value,
            phoneCredential: credential));

    either.fold((failure) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }, (success) {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    });
    state.copyWith(autoVerified: true);
  }

  Future<void> submit(BuildContext context) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId, smsCode: state.otp.value);
    emit(
      state.copyWith(
          authCredential: credential, status: FormzStatus.submissionInProgress),
    );

    final signUpSate = context.read<SignUpFormCubit>().state;
    final either = await _phoneSignUp(
        params: PhoneSignUpParams(
            name: signUpSate.name.value,
            phoneNumber: signUpSate.phoneNumber.value,
            phoneCredential: credential));
    either.fold((failure) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }, (success) {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    });
  }
}
