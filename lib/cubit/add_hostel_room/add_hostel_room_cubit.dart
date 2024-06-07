import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../data/hostel.dart';
import '../../data/room.dart';
import '../../utilities/utils.dart';

part 'add_hostel_room_state.dart';

class AddHostelRoomCubit extends Cubit<AddHostelRoomState> {
  AddHostelRoomCubit() : super(AddingHostelRoomInitial());

 final dio = Dio();

  Future<void> addHostelRoom(Room room, int hostelId) async {
    var url = "$baseUrl/hostelroom/$hostelId/addroom";
    try{
      emit(AddingHostelRoomInProgress());
      var options = Options(
          headers: {
            "Accept": "application/json",
            "content-type":"application/json",
            "Access-Control-Allow-Origin": "*"
          }
      );
      var response = await dio.post(
          url,
          options: options,
          data: jsonEncode(
              {'roomCategory': room.roomCategory,
                'roomLabel': room.roomLabel,
                'price': room.price}
          ));
      if(response.statusCode == 200) {
        var room = Room.fromJson(response.data);
        emit(AddingHostelRoomSucceeded(room));
      } else {
        emit(AddingHostelRoomFailed("Adding failed."));
      }
    } catch (e){
      emit(AddingHostelRoomFailed(e.toString()));
    }
  }

}


