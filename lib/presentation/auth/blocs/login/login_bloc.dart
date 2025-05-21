import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skl_bp/data/dataresource/auth_service.dart';
import 'package:flutter_skl_bp/data/models/response/auth_response_model.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource authRemoteDatasource;

  LoginBloc(this.authRemoteDatasource) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      final response = await authRemoteDatasource.login(event.email, event.password);
      response.fold(
        (l) => emit(LoginFailure(message: l)),
        (r) => emit(LoginSuccess(loginModel: r)),
      );
    });
  }
}
