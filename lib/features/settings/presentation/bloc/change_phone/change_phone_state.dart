part of 'change_phone_cubit.dart';

class ChangePhoneState extends Equatable {
  const ChangePhoneState({
    this.phoneNumber =const PhoneNumber.pure(),
    this.status = FormzStatus.pure,
  });

  final PhoneNumber phoneNumber;
  final FormzStatus status;

  ChangePhoneState copyWith({
    PhoneNumber? phoneNumber,
    FormzStatus? status,
  }) {
    return ChangePhoneState(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [phoneNumber, status];
}
