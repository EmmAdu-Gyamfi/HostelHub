part of 'upload_hostel_photo_cubit.dart';

abstract class UploadHostelPhotoState extends Equatable {
  const UploadHostelPhotoState();

  @override
  List<Object?> get props => [];
}

class UploadHostelPhotoInitial extends UploadHostelPhotoState {}

class UploadHostelPhotoInProgress extends UploadHostelPhotoState {

  final double progress;

  UploadHostelPhotoInProgress(this.progress);

  @override
  // TODO: implement props
  List<Object?> get props => [progress];

}

class UploadHostelPhotoFailed extends UploadHostelPhotoState {

  final String message;

  UploadHostelPhotoFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class UploadHostelPhotoSucceeded extends UploadHostelPhotoState {
  final List<Photo> photos;
  UploadHostelPhotoSucceeded(this.photos);

  @override
  // TODO: implement props
  List<Object?> get props => [photos];
}
