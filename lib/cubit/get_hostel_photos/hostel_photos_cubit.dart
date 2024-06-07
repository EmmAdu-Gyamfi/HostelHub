import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/file_ids.dart';
import '../../data/photo.dart';
import '../../utilities/utils.dart';

part 'hostel_photos_state.dart';

class HostelPhotosCubit extends Cubit<GetHostelPhotosState> {
  HostelPhotosCubit() : super(HostelPhotosInitial());

  final _dio = Dio();

  Future<void> loadHostelPhotos(int hostelId) async {
    try {
      emit(HostelPhotosLoadingInProgress());
      var options = Options(
          headers: {
            "Accept": "application/json",
            "content-type":"application/json",
            "Access-Control-Allow-Origin": "*"
          }
      );
      // var url = Uri.parse("$baseUrl/hostelphoto/$newHostel/getphotos");
      var response = await _dio.get(
          "$baseUrl/hostelphoto/$hostelId/HostelImages", options: options);

      if (response.statusCode == 200) {
        var mapList = response.data as List;
        var photos = mapList.map((e) => Photo.fromJson(e)).toList();
        emit(HostelPhotosLoadingSucceeded(photos));
      } else {
        emit(HostelPhotosLoadingFailed(response.statusMessage));
      }
    } catch (e) {
      emit(HostelPhotosLoadingFailed(e.toString()));
    }
  }

}