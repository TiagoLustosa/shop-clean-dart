import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/auth/bloc/auth_state.dart';
import '../../../domain/usecases/base_usecase/base_usecase.dart';
import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UseCase usecase;
  AuthBloc(this.usecase) : super(const AuthStart()) {
    on<AuthWithEmailSend>(authWithEmailSend);
  }
  FutureOr<void> authWithEmailSend(
      AuthWithEmailSend event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await usecase(event.credentials);
    emit(result.fold(
      (l) => AuthError(l),
      (r) => AuthSuccess(r),
    ));
  }
}
