import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../data/photo.dart';
import '../../utilities/utils.dart';
import 'package:http_parser/http_parser.dart';
part 'upload_room_photo_state.dart';

class UploadRoomPhotoCubit extends Cubit<UploadRoomPhotoState> {
  UploadRoomPhotoCubit() : super(UploadRoomPhotoInitial());

  Future<void> uploadPhoto({required Uint8List image, required int roomId}) async {

    var transferedLength = 0;
    var totalLength = image.length;

    try {
      emit(UploadRoomPhotoInProgress(0));
      var url = Uri.parse("$baseUrl/roomphoto/$roomId/AddPhoto");
      var headers = {
        "Accept": "application/json",
        "content-type":"application/json",
        "Access-Control-Allow-Origin": "*"
      };

      final request = MultipartRequest(
        'POST',
        url,
        // o
        // onProgress: (int bytes, int total) {
        //   final progress = bytes / total;
        //   emit(UploadingHostelImageInProgress('progress: $progress ($bytes/$total)'));
        // },
      );

      request.headers.addAll(headers);
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          image,
          contentType: MediaType("image", "jpg"),
          filename: "image.jpg",
        ),
      );
      final streamedResponse = await request.send();
      //   streamedResponse.stream.listen((value) {
      //     transferedLength += value.length;
      //     var progress = transferedLength/totalLength;
      //     emit(UploadHostelPhotoInProgress(progress));
      // });
      // if(streamedResponse.statusCode == 200){
      //   emit(UploadingHostelImageSucceeded());
      // }

      var response = await http.Response.fromStream(streamedResponse);
      if(response.statusCode == 200){
        Iterable list = await jsonDecode(response.body) ;
        var photos = list.map((e) => Photo.fromJson(e)).toList();
        emit(UploadRoomPhotoSucceeded(photos));
      } else {
        emit(UploadRoomPhotoFailed("Upload failed"));
      }


    } catch (e) {
      emit(UploadRoomPhotoFailed(e.toString()));
    }
  }
}
