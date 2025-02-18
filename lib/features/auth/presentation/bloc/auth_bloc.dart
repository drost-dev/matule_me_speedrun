import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:matule_me_speedrun/features/database/data/repos/supabase/supabase_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    SupabaseRepo sbRepo = GetIt.I<SupabaseRepo>();

    on<AuthEvent>((event, emit) async {
      emit(AuthProcessing());
      switch (event) {
        case AuthLoad():
          if (sbRepo.isSignedIn()) {
            emit(AuthSuccess());
          } else {
            emit(AuthLoaded());
          }
          break;
        case AuthSignIn():
          try {
            await sbRepo.signIn(email: event.email, password: event.password);
            emit(AuthSuccess());
          } catch (e) {
            switch (e) {
              case AuthException():
                emit(AuthError(message: e.toString()));
                break;
              default:
                emit(AuthError(message: 'An unhandled error occurred'));
            }
          }
          break;
        case AuthSignUp():
          try {
            await sbRepo.signUp(
                name: event.name, email: event.email, password: event.password);
            emit(AuthSuccess());
          } catch (e) {
            switch (e) {
              case AuthException():
                emit(AuthError(message: e.toString()));
                break;
              default:
                emit(AuthError(message: 'An unhandled error occurred'));
            }
          }
          break;
        case AuthRequestCode():
          try {
            await sbRepo.sendOtp(email: event.email);
            emit(AuthWaitingCode(email: event.email));
          } catch (e) {
            switch (e) {
              case AuthException():
                emit(AuthError(message: e.toString()));
                break;
              default:
                emit(AuthError(message: 'An unhandled error occurred'));
            }
          }
          break;
        case AuthSignInOtp():
          try {
            await sbRepo.verifyOtp(email: event.email, code: event.code);
            emit(AuthSuccess());
          } catch (e) {
            switch (e) {
              case AuthException():
                emit(AuthError(message: e.toString()));
                break;
              default:
                emit(AuthError(message: 'An unhandled error occurred'));
            }
          }
          break;
      }
    });
  }
}
