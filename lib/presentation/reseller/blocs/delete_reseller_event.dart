abstract class DeleteResellerEvent {}

class DeleteResellerRequested extends DeleteResellerEvent {
  final int id;
  DeleteResellerRequested(this.id);
}
