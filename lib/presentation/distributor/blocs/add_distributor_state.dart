// lib/presentation/distributor/blocs/add_distributor_state.dart
part of 'add_distributor_bloc.dart';

abstract class AddDistributorState extends Equatable {
  const AddDistributorState();

  @override
  List<Object> get props => [];
}

class AddDistributorInitial extends AddDistributorState {}

class AddDistributorLoading extends AddDistributorState {}

class AddDistributorSuccess extends AddDistributorState {}

class AddDistributorError extends AddDistributorState {
  final String message;
  const AddDistributorError(this.message);

  @override
  List<Object> get props => [message];
}
