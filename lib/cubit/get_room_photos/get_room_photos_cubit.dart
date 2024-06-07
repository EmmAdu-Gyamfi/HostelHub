import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../data/photo.dart';
import '../../utilities/utils.dart';

part 'get_room_photos_state.dart';

class GetRoomPhotosCubit extends Cubit<GetRoomPhotosState> {
  GetRoomPhotosCubit() : super(GetRoomPhotosInitial());


final _dio = Dio();

Future<void> loadRoomPhotos(int roomId) async {
  try {
    emit(RoomPhotosLoadingInProgress());
    var options = Options(
        headers: {
          "Accept": "application/json",
          "content-type":"application/json",
          "Access-Control-Allow-Origin": "*"
        }
    );
    var response = await _dio.get(
        "$baseUrl/roomphoto/$roomId/RoomImages", options: options);

    if (response.statusCode == 200) {
      var mapList = response.data as List;
      var photos = mapList.map((e) => Photo.fromJson(e)).toList();
      emit(RoomPhotosLoadingSucceeded(photos));
    } else {
      emit(RoomPhotosLoadingFailed(response.statusMessage));
    }
  } catch (e) {
    emit(RoomPhotosLoadingFailed(e.toString()));
  }
}
}

