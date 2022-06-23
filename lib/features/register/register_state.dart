
import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {

  const RegisterState();

  @override
  List<Object> get props => [];

}

class RegisterLoading extends RegisterState {}

class Unregistered extends RegisterState {}

class Registered extends RegisterState {

}

class RegistrationFailure extends RegisterState {
  final String message;

  RegistrationFailure({required this.message});

  @override
  List<Object> get props => [message];
}