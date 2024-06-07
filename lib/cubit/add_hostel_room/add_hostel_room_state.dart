part of 'add_hostel_room_cubit.dart';

abstract class AddHostelRoomState extends Equatable {
  const AddHostelRoomState();
  @override
  List<Object?> get props => [];
}

class AddingHostelRoomInitial extends AddHostelRoomState {

}
class AddingHostelRoomInProgress extends AddHostelRoomState {

}

class AddingHostelRoomFailed extends AddHostelRoomState {

  final String Message;

  AddingHostelRoomFailed(this.Message);

@override
  // TODO: implement props
    List<Object?> get props => [Message];
}

class AddingHostelRoomSucceeded extends AddHostelRoomState {
 final Room room;
 AddingHostelRoomSucceeded(this.room);
 @override
  // TODO: implement props
  List<Object?> get props => [room];
}
