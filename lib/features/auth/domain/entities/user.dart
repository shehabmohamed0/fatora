import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String? email;
  final String? photoURL;
  final String phoneNumber;

  const User(
      {required this.id,
      required this.name,
      required this.email,
      this.photoURL,
      required this.phoneNumber});

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photoURL,
    String? phoneNumber,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  static const empty = User(id: '', email: '', name: '', phoneNumber: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => id.isEmpty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => id.isNotEmpty;

  @override
  List<Object?> get props => [id, name, email, photoURL];
}
