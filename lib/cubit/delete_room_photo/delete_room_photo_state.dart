part of 'delete_room_photo_cubit.dart';

abstract class DeleteRoomPhotoState extends Equatable {
  const DeleteRoomPhotoState();

  @override
  List<Object?> get props => [];
}

class DeleteRoomPhotoInitial extends DeleteRoomPhotoState {

}

class DeleteRoomPhotoInProgress extends DeleteRoomPhotoState {

}

class DeleteRoomPhotoFailed extends DeleteRoomPhotoState {
  final String? Message;

  DeleteRoomPhotoFailed(this.Message);

  @override
  // TODO: implement props
  List<Object?> get props => [Message];
}

class DeleteRoomPhotoSucceeded extends DeleteRoomPhotoState {

}
