part of 'phone_form_cubit.dart';

class PhoneFormState extends Equatable {
  const PhoneFormState(
      {this.phoneNumber = const PhoneNumber.pure(),
      this.status = FormzStatus.pure,
      this.verificationId,
      this.errorMessage});
  final PhoneNumber phoneNumber;
  final FormzStatus status;
  final String? verificationId;
  final String? errorMessage;
  PhoneFormState copyWith({
    PhoneNumber? phoneNumber,
    FormzStatus? status,
    String? verificationId,
    String? errorMessage,
  }) {
    return PhoneFormState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      verificationId: verificationId ?? this.verificationId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [phoneNumber, status, verificationId, errorMessage];
}
