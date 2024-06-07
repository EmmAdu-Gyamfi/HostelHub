part of 'get_room_photos_cubit.dart';

abstract class GetRoomPhotosState extends Equatable {
  const GetRoomPhotosState();
  @override
  List<Object?> get props => [];
}

class GetRoomPhotosInitial extends GetRoomPhotosState {

}


class RoomPhotosInitial extends GetRoomPhotosState {

}

class RoomPhotosLoadingInProgress extends GetRoomPhotosState{

}

class RoomPhotosLoadingFailed extends GetRoomPhotosState{
  final String? Message;

  const RoomPhotosLoadingFailed(this.Message);

  @override
  // TODO: implement props
  List<Object?> get props => [Message];
}

class RoomPhotosLoadingSucceeded extends GetRoomPhotosState{
  final List<Photo> data;

  const RoomPhotosLoadingSucceeded(this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
