part of 'upload_room_photo_cubit.dart';

abstract class UploadRoomPhotoState extends Equatable {
  const UploadRoomPhotoState();
  @override
  List<Object?> get props => [];
}

class UploadRoomPhotoInitial extends UploadRoomPhotoState {}

class UploadRoomPhotoInProgress extends UploadRoomPhotoState {

  final double progress;

  UploadRoomPhotoInProgress(this.progress);

  @override
  // TODO: implement props
  List<Object?> get props => [progress];

}

class UploadRoomPhotoFailed extends UploadRoomPhotoState {

  final String message;

  UploadRoomPhotoFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class UploadRoomPhotoSucceeded extends UploadRoomPhotoState {
  final List<Photo> photos;
  UploadRoomPhotoSucceeded(this.photos);

  @override
  // TODO: implement props
  List<Object?> get props => [photos];
}



