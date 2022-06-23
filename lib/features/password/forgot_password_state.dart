import 'package:equatable/equatable.dart';

class ForgotPasswordState extends Equatable {

  const ForgotPasswordState();

  @override
  List<Object> get props => [];

}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordFail extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {

}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String message;

  ForgotPasswordFailure({required this.message});

  @override
  List<Object> get props => [message];
}