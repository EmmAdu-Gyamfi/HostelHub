part of 'edit_room_cubit.dart';

abstract class EditRoomState extends Equatable {
  const EditRoomState();
  @override
  List<Object?> get props => [];
}

class EditRoomInitial extends EditRoomState {

}

class EditRoomInProgress extends EditRoomState {

}

class EditRoomFailed extends EditRoomState {

  final String Message;

  EditRoomFailed(this.Message);

  @override
  // TODO: implement props
  List<Object?> get props => [Message];
}

class EditRoomSucceeded extends EditRoomState {
  // final Room room;
  // EditRoomSucceeded(this.room);
  // @override
  // // TODO: implement props
  // List<Object?> get props => [room];
}
