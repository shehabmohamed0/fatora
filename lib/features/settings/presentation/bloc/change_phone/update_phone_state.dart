part of 'update_phone_cubit.dart';

class UpdatePhoneState extends Equatable {
  const UpdatePhoneState({
    this.phoneNumber = const PhoneNumber.pure(),
    this.phoneFormStatus = FormzStatus.pure,
    this.otp = const OTP.pure(),
    this.otpFormStatus = FormzStatus.pure,
    this.verificationId = '',
    this.phoneAuthCredential,
    this.autoRetrievedSMS = false,
    this.otpFormCompletedOneTime = false,
    this.errorMessage,
    this.step = 0,
  });

  final PhoneNumber phoneNumber;
  final FormzStatus phoneFormStatus;

  final OTP otp;
  final FormzStatus otpFormStatus;
  final String verificationId;
  final PhoneAuthCredential? phoneAuthCredential;
  final bool autoRetrievedSMS;
  final bool otpFormCompletedOneTime;

  final String? errorMessage;
  final int step;
  UpdatePhoneState copyWith({
    PhoneNumber? phoneNumber,
    FormzStatus? phoneFormStatus,
    OTP? otp,
    FormzStatus? otpFormStatus,
    String? verificationId,
    PhoneAuthCredential? phoneAuthCredential,
    bool? otpFormCompletedOneTime,
    int? step,
    String? errorMessage,
  }) {
    return UpdatePhoneState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneFormStatus: phoneFormStatus ?? this.phoneFormStatus,
      otp: otp ?? this.otp,
      verificationId: verificationId ?? this.verificationId,
      phoneAuthCredential: phoneAuthCredential ?? this.phoneAuthCredential,
      otpFormStatus: otpFormStatus ?? this.otpFormStatus,
      otpFormCompletedOneTime:
          otpFormCompletedOneTime ?? this.otpFormCompletedOneTime,
      step: step ?? this.step,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        phoneFormStatus,
        otp,
        otpFormStatus,
        phoneAuthCredential,
        verificationId,
        autoRetrievedSMS,
        otpFormCompletedOneTime,
        step,
        errorMessage
      ];
}
