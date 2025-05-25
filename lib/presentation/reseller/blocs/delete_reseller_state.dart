abstract class DeleteResellerState {}

class DeleteResellerInitial extends DeleteResellerState {}

class DeleteResellerLoading extends DeleteResellerState {}

class DeleteResellerSuccess extends DeleteResellerState {}

class DeleteResellerFailure extends DeleteResellerState {
  final String error;
  DeleteResellerFailure(this.error);
}
