import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hostel_hub_mobile_app/data/hostel.dart';
import 'package:hostel_hub_mobile_app/utilities/utils.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'add_hostel_state.dart';

class AddHostelCubit extends Cubit<AddHostelState> {
  final dio =Dio();

  AddHostelCubit() : super(AddHostelInitial());

  Future<void> addHostel(Hostel hostel) async {
    var url = "$baseUrl/hostel";
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try{
      emit(AddHostelInProgress());
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
              {'name': hostel.name,
                'locality': hostel.locality,
                'address': hostel.address,
                'condition': hostel.condition,
                'furnishing':hostel.furnishing,
                'minimumRentTime': hostel.minimumRentTime,
                'negotiation': hostel.negotiation,
                'city': hostel.city,
                'region': hostel.region,
                'minimumPriceRange': hostel.minimumPriceRange,
                'maximumPriceRange': hostel.maximumPriceRange,
                'description':hostel.description,
                'phoneNumber' : hostel.phoneNumber,
                'alternativePhoneNumber' : hostel.alternativePhoneNumber,
                'laundryServices' : hostel.laundryServices,
                'security' : hostel.security,
                'studyRoom' : hostel.studyRoom,
                'addedBy' : hostel.addedBy,
                'wiFi' : hostel.wiFi,
              }
          ));
      if(response.statusCode == 200) {
        var hostel = Hostel.fromJson(response.data);
        emit(AddHostelSucceeded(hostel));
      } else {
        emit(AddHostelFailed("Adding failed."));
      }
    } catch (e){
      emit(AddHostelFailed(e.toString()));
    }
  }

}
