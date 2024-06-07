import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/hostel_review.dart';
import '../../utilities/utils.dart';

part 'add_hostel_review_state.dart';

class AddHostelReviewCubit extends Cubit<AddHostelReviewState> {
  AddHostelReviewCubit() : super(AddHostelReviewInitial());

  final dio =Dio();

  Future<void> addFeedback(HostelReview hostelReview) async {
    var url = "$baseUrl/hostelreview";
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try{
      emit(AddHostelReviewInProgress());
      var options = Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "content-type":"application/json",
            "Access-Control-Allow-Origin": "*"
          }
      );
      var response = await dio.post(
          url,
          options: options,
          data: jsonEncode(
              {'comment': hostelReview.comment,
                'hostelId': hostelReview.hostelId,
                'userId': hostelReview.userId,
                'sentiment': hostelReview.sentiment,
                'date': hostelReview.date,
                'userName': hostelReview.userName
              }
          ));
      if(response.statusCode == 204) {
        // var hostel = Hostel.fromJson(response.data);
        emit(AddHostelReviewSucceeded());
      } else {
        emit(AddHostelReviewsFailed("failed."));
      }
    } catch (e){
      emit(AddHostelReviewsFailed(e.toString()));
    }
  }
}
