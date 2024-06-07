import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'delete_hostel_photo_state.dart';

class DeleteHostelPhotoCubit extends Cubit<DeleteHostelPhotoState> {
  DeleteHostelPhotoCubit() : super(DeleteHostelPhotoInitial());

  Future<void> deleteHostelPhoto(int fileId) async {
    var url = Uri.parse("https://10.0.2.2:5001/api/hostelphoto/$fileId");
    try{
      emit(DeleteHostelPhotoInProgress());
      var response = await http.delete(url, headers: {
        "Accept": "application/json",
        "content-type":"application/json"
      });
      if(response.statusCode == 204) {
        emit(DeleteHostelPhotoSucceeded());
      } else {
        emit(DeleteHostelPhotoFailed(response.reasonPhrase));
      }
    } catch (e){
      emit(DeleteHostelPhotoFailed(e.toString()));
    }
  }
}

