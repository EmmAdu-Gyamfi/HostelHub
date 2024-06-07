import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/hostel_review.dart';
import '../../utilities/utils.dart';

part 'get_hostel_reviews_state.dart';

class GetHostelReviewsCubit extends Cubit<GetHostelReviewsState> {
  GetHostelReviewsCubit() : super(GetHostelReviewsInitial());
  final _dio = Dio();

  Future<void> loadReview(int hostelId) async{
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try{
      emit(GetHostelReviewsInProgress());
      var url = Uri.parse("$baseUrl/hostel");
      var options = Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "content-type":"application/json",
            "Access-Control-Allow-Origin": "*"
          }
      );
      var response = await _dio.get("$baseUrl/hostel/getReviews/$hostelId", options: options);

      if(response.statusCode == 200){
        Iterable list = await jsonDecode(jsonEncode(response.data)) ;
        List<HostelReview> hostels = list.map((e) => HostelReview.fromJson(e)).toList();
        emit(GetHostelReviewsSucceeded(hostels));

      } else{
        emit(GetHostelReviewsFailed(response.statusMessage));
      }
    } catch(e){
      emit(GetHostelReviewsFailed(e.toString()));
    }
  }
}
