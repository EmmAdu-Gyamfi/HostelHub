import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
part 'delete_room_photo_state.dart';

class DeleteRoomPhotoCubit extends Cubit<DeleteRoomPhotoState> {
  DeleteRoomPhotoCubit() : super(DeleteRoomPhotoInitial());

  Future<void> deleteRoomPhoto(int fileId) async {
    var url = Uri.parse("https://10.0.2.2:5001/api/roomphoto/$fileId");
    try{
      emit(DeleteRoomPhotoInProgress());
      var response = await http.delete(url, headers: {
        "Accept": "application/json",
        "content-type":"application/json"
      });
      if(response.statusCode == 204) {
        emit(DeleteRoomPhotoSucceeded());
      } else {
        emit(DeleteRoomPhotoFailed(response.reasonPhrase));
      }
    } catch (e){
      emit(DeleteRoomPhotoFailed(e.toString()));
    }
  }
}
