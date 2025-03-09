part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoaded extends AuthState {}

final class AuthProcessing extends AuthState {}

final class AuthWaitingCode extends AuthState {
  final String email;

  AuthWaitingCode({required this.email});

  @override
  List<Object?> get props => [email];
}

final class AuthSuccess extends AuthState {
  AuthSuccess({this.user});

  final User? user;
  @override
  List<Object?> get props => [user];
}

final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}
