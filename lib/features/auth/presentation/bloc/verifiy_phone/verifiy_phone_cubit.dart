import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fatora/core/errors/failures/auth/sign_in_with_credential_failure.dart';
import 'package:fatora/core/errors/failures/failures.dart';
import 'package:fatora/core/params/auth/phone_sign_in_params.dart';
import 'package:fatora/core/params/auth/phone_sign_up_params.dart';
import 'package:fatora/features/auth/domain/usecases/phone_sign_up.dart';
import 'package:fatora/features/auth/domain/usecases/sign_in_with_phone.dart';
import 'package:fatora/features/settings/domain/usecases/update_phone_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../../core/form_inputs/otp.dart';

part 'verifiy_phone_state.dart';

abstract class VerifiyPhoneCubit extends Cubit<VerifiyPhoneState> {
  late final StreamSubscription<String> _codeSubscription;
  final SmsAutoFill _autoFill;
  VerifiyPhoneCubit(this._autoFill) : super(const VerifiyPhoneState()) {
    _autoFill.listenForCode().then((value) {
      _codeSubscription = _autoFill.code.listen((code) {
        log(code);
        final newOTP = OTP.dirty(code);
        emit(
          state.copyWith(
            autoRecievedCode: true,
            otp: newOTP,
            status: Formz.validate([newOTP]),
          ),
        );
      });
    });
  }

  void otpChanged(String value) {
    final newOTP = OTP.dirty(value);
    emit(state.copyWith(
      otp: newOTP,
      status: Formz.validate([newOTP]),
    ));
  }

  void onComplete() async {
    emit(state.copyWith(autoVerified: true));
  }

  @override
  Future<void> close() {
    _codeSubscription.cancel();
    return super.close();
  }
}

@injectable
class PhoneSignInVerificationCubit extends VerifiyPhoneCubit {
  PhoneSignInVerificationCubit(
    this._signInWithPhone,
    SmsAutoFill autoFill,
  ) : super(autoFill);
  final SignInWithPhone _signInWithPhone;

  Future<void> signInWithPhoneNumber(String verificationId) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final PhoneAuthCredential phoneCredential = PhoneAuthProvider.credential(
        smsCode: state.otp.value, verificationId: verificationId);
    final either =
        await _signInWithPhone(params: PhoneSignInParams(phoneCredential));

    either.fold((failure) {
      if (failure is SignInWithCredentialFailure) {
        emit(
          state.copyWith(
            errorMessage: failure.message,
            status: FormzStatus.submissionFailure,
          ),
        );
      } else if (failure is ServerFailure) {
        emit(
          state.copyWith(
            errorMessage: failure.message,
            status: FormzStatus.submissionFailure,
          ),
        );
      }
    }, (success) {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    });
  }
}

@injectable
class UpdatePhoneVerificationCubit extends VerifiyPhoneCubit {
  UpdatePhoneVerificationCubit(this._updatePhoneNumber, SmsAutoFill autoFill)
      : super(autoFill);
  final UpdatePhoneNumber _updatePhoneNumber;

  Future<void> submit() async {}
}

@injectable
class PhoneSignUpVerificationCubit extends VerifiyPhoneCubit {
  PhoneSignUpVerificationCubit(this._phoneSignUp, SmsAutoFill autoFill)
      : super(autoFill);
  final PhoneSignUp _phoneSignUp;

  Future<void> submit(
      String name, String phoneNumber, String verificationId) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: state.otp.value);

    final either = await _phoneSignUp(
      params: PhoneSignUpParams(
        name: name,
        phoneNumber: phoneNumber,
        phoneCredential: credential,
      ),
    );
    either.fold((failure) {
      if (failure is SignInWithCredentialFailure) {
        emit(state.copyWith(
            errorMessage: failure.message,
            status: FormzStatus.submissionFailure));
      }
    }, (success) {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    });
  }
}
