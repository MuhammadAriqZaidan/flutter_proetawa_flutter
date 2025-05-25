import 'package:equatable/equatable.dart';

abstract class AddResellerState extends Equatable {
  const AddResellerState();

  @override
  List<Object> get props => [];
}

class AddResellerInitial extends AddResellerState {}

class AddResellerLoading extends AddResellerState {}

class AddResellerSuccess extends AddResellerState {}

class AddResellerError extends AddResellerState {
  final String message;
  const AddResellerError(this.message);

  @override
  List<Object> get props => [message];
}
