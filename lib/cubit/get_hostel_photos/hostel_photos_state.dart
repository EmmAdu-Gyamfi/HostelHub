part of 'hostel_photos_cubit.dart';

abstract class GetHostelPhotosState extends Equatable {
  const GetHostelPhotosState();
  @override
  List<Object?> get props => [];
}

class HostelPhotosInitial extends GetHostelPhotosState {

}

class HostelPhotosLoadingInProgress extends GetHostelPhotosState{

}

class HostelPhotosLoadingFailed extends GetHostelPhotosState{
  final String? message;

  const HostelPhotosLoadingFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class HostelPhotosLoadingSucceeded extends GetHostelPhotosState{
  final List<Photo> data;

  const HostelPhotosLoadingSucceeded(this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
