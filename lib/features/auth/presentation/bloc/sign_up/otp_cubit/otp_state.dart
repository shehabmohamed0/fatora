part of 'otp_cubit.dart';

class OTPState extends Equatable {
  const OTPState({
    this.otp = const OTP.pure(),
    this.status = FormzStatus.pure,
    this.verificationId = '',
    this.autoVerified = false,
    this.autoGetCode = false,
    this.errorMessage,
  });

  final OTP otp;
  final String verificationId;
  final bool autoVerified;
  final bool autoGetCode;
  final String? errorMessage;
  final FormzStatus status;

  @override
  List<Object?> get props => [
        otp,
        verificationId,
        autoVerified,
        autoGetCode,
        errorMessage,
        status
      ];

  OTPState copyWith({
    OTP? otp,
    String? smsCode,
    String? verificationId,
    FormzStatus? status,
    bool? autoVerified,
    bool? autoGetCode,
    String? errorMessage,
  }) {
    return OTPState(
      otp: otp ?? this.otp,
      verificationId: verificationId ?? this.verificationId,
      autoVerified: autoVerified ?? this.autoVerified,
      autoGetCode: autoGetCode ?? this.autoGetCode,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
