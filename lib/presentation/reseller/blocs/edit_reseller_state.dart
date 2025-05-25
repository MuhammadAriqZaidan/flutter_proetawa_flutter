abstract class EditResellerState {}

class EditResellerInitial extends EditResellerState {}

class EditResellerLoading extends EditResellerState {}

class EditResellerSuccess extends EditResellerState {}

class EditResellerFailure extends EditResellerState {
  final String message;

  EditResellerFailure(this.message);
}
