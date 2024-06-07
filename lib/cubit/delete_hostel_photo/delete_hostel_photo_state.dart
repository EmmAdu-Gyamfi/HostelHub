part of 'delete_hostel_photo_cubit.dart';

abstract class DeleteHostelPhotoState extends Equatable {
  const DeleteHostelPhotoState();

  @override
  List<Object?> get props => [];
}

class DeleteHostelPhotoInitial extends DeleteHostelPhotoState {

}

class DeleteHostelPhotoInProgress extends DeleteHostelPhotoState {

}

class DeleteHostelPhotoFailed extends DeleteHostelPhotoState {
  final String? Message;

  DeleteHostelPhotoFailed(this.Message);

  @override
  // TODO: implement props
  List<Object?> get props => [Message];
}

class DeleteHostelPhotoSucceeded extends DeleteHostelPhotoState {

}
