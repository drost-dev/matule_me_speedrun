part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthLoad extends AuthEvent {}

final class AuthSignIn extends AuthEvent {
  final String email;
  final String password;
  
  AuthSignIn({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;
  
  AuthSignUp({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object?> get props => [email, password, name];
}

final class AuthRequestCode extends AuthEvent {
  final String email;
  
  AuthRequestCode({
    required this.email
  });

  @override
  List<Object?> get props => [email];
}

final class AuthSignInOtp extends AuthEvent {
  final String email;
  final String code;

  AuthSignInOtp({
    required this.email,
    required this.code,
  });

  @override
  List<Object?> get props => [email, code];
}