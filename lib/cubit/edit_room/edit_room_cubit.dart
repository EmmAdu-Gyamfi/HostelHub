import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import '../../data/hostel.dart';

part 'edit_room_state.dart';

class EditRoomCubit extends Cubit<EditRoomState> {
  EditRoomCubit() : super(EditRoomInitial());

  final _dio = Dio();


  Future<void> putRoom(Room room) async {
    var url = Uri.parse("https://10.0.2.2:5001/api/room/${room.roomId}");
    try{
      emit(EditRoomInProgress());
      // var parsedDate = DateTime.parse(dueDate!);
      var response = await http.put(url, headers: {
        "Accept": "application/json",
        "content-type":"application/json"
      }, body: jsonEncode({
        'roomId': room.roomId,
        'roomCategory': room.roomCategory,
        'roomLabel': room.roomLabel,
        'price': room.price}));
      if(response.statusCode == 204) {
        // loadTodoItem();
        emit(EditRoomSucceeded());
      } else {
        emit(EditRoomFailed(response.reasonPhrase.toString()));
      }
    } catch (e){
      emit(EditRoomFailed(e.toString()));
    }
  }
}
