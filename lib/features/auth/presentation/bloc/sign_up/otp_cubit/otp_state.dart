part of 'otp_cubit.dart';

class OTPState extends Equatable {
  const OTPState({
    this.otp = const OTP.pure(),
    this.status = FormzStatus.pure,
    this.verificationId = '',
    this.autoVerified = false,
    this.smsCode = '',
  });

  final OTP otp;
  final String smsCode;
  final String verificationId;
  final bool autoVerified;
  final FormzStatus status;

  @override
  List<Object?> get props => [otp, status];

  OTPState copyWith({
    OTP? otp,
    String? smsCode,
    String? verificationId,
    FormzStatus? status,
    AuthCredential? authCredential,
    bool? autoVerified,
  }) {
    return OTPState(
      otp: otp ?? this.otp,
      verificationId: verificationId ?? this.verificationId,
      smsCode: smsCode ?? this.smsCode,
      autoVerified: autoVerified ?? this.autoVerified,
      status: status ?? this.status,
    );
  }
}

abstract class OTPStateP extends Equatable {}

class OTPSend extends OTPStateP {
  final OTP otp;
  final String smsCode;
  final String verificationId;
  OTPSend(
      {this.otp = const OTP.pure(),
      this.verificationId = '',
      this.smsCode = ''});
  OTPState copyWith({
    OTP? otp,
    String? smsCode,
    String? verificationId,
    FormzStatus? status,
    AuthCredential? authCredential,
  }) {
    return OTPState(
      otp: otp ?? this.otp,
      verificationId: verificationId ?? this.verificationId,
      smsCode: smsCode ?? this.smsCode,
    );
  }

  @override
  List<Object?> get props => [otp, smsCode, verificationId];
}

class OTPSuccess extends OTPStateP {
  @override
  List<Object?> get props => throw UnimplementedError();
}
