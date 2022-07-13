import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/auth_with_email.dart';
import 'package:shop_clean_arch/app/shop/presenter/auth/bloc/auth_state.dart';
import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthWithEmail usecase;
  AuthBloc(this.usecase) : super(const AuthStart()) {
    on<AuthWithEmailSend>(authWithEmailSend);
  }
  FutureOr<void> authWithEmailSend(
      AuthWithEmailSend event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await usecase(event.email, event.password);
    print(result);
    emit(result.fold(
      (l) => AuthError(l),
      (r) => AuthSuccess(r),
    ));
  }
}
