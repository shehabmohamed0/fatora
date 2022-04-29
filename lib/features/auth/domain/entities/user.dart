import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String? photoURL;

  const User({
    required this.id,
    this.name,
    this.email,
    this.photoURL,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photoURL,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => id.isEmpty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => id.isNotEmpty;

  @override
  List<Object?> get props => [id, name, email, photoURL];
}
