part of 'phone_sign_in_cubit.dart';

@immutable
class PhoneSignInState extends Equatable {
  const PhoneSignInState(
      {this.phoneNumber = const PhoneNumber.pure(),
      this.otp = const OTP.pure(),
      this.verificationID,
      this.phoneFormStatus = FormzStatus.pure,
      this.smsFormStatus = FormzStatus.pure,
      this.errorMessage,
      this.firstFormCompletion = true,
      this.autoFilled = false,
      this.step = 0});
  final PhoneNumber phoneNumber;
  final OTP otp;
  final String? verificationID;
  final FormzStatus phoneFormStatus;
  final FormzStatus smsFormStatus;
  final String? errorMessage;
  final bool firstFormCompletion;
  final bool autoFilled;
  final int step;
  PhoneSignInState copyWith({
    PhoneNumber? phoneNumber,
    OTP? otp,
    String? verificationID,
    FormzStatus? phoneFormStatus,
    FormzStatus? smsFormStatus,
    bool? firstFormCompletion,
    bool? autoFilled,
    int? step,
    String? errorMessage,
  }) {
    return PhoneSignInState(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        otp: otp ?? this.otp,
        verificationID: verificationID ?? this.verificationID,
        firstFormCompletion: firstFormCompletion ?? this.firstFormCompletion,
        autoFilled: autoFilled ?? this.autoFilled,
        phoneFormStatus: phoneFormStatus ?? this.phoneFormStatus,
        smsFormStatus: smsFormStatus ?? this.smsFormStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        step: step ?? this.step);
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        otp,
        verificationID,
        phoneFormStatus,
        smsFormStatus,
        errorMessage,
        firstFormCompletion,
        autoFilled,
        step
      ];
}
