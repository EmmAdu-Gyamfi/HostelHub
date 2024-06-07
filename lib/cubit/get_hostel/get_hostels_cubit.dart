import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/hostel.dart';
import '../../utilities/utils.dart';

part 'get_hostels_state.dart';
class GetHostelsCubit extends Cubit<HostelsState> {
  GetHostelsCubit() : super(HostelsInitial());
  
  final _dio = Dio();

  Future<void> loadHostels() async{
    try{
      emit(HostelsLoadingInProgress());
      var url = Uri.parse("$baseUrl/hostel");
      var options = Options(
          headers: {
            "Accept": "application/json",
            "content-type":"application/json",
            "Access-Control-Allow-Origin": "*"
          }
      );
      var response = await _dio.get("$baseUrl/hostel", options: options);

      if(response.statusCode == 200){
        Iterable list = await jsonDecode(jsonEncode(response.data)) ;
        List<Hostel> hostels = list.map((e) => Hostel.fromJson(e)).toList();
        emit(HostelsLoadingSucceeded(hostels));

      } else{
        emit(HostelsLoadingFailed(response.statusMessage));
      }
    } catch(e){
      emit(HostelsLoadingFailed(e.toString()));
    }
  }


  Future<void> loadUserHostels() async{
    try{
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('userId');
      emit(HostelsLoadingInProgress());
      var url = Uri.parse("$baseUrl/hostel/getuserhostels/$userId");
      var options = Options(
          headers: {
            "Accept": "application/json",
            "content-type":"application/json",
            "Access-Control-Allow-Origin": "*"
          }
      );
      var response = await _dio.get("$baseUrl/hostel/getuserhostels/$userId", options: options);

      if(response.statusCode == 200){
        Iterable list = await jsonDecode(jsonEncode(response.data)) ;
        List<Hostel> hostels = list.map((e) => Hostel.fromJson(e)).toList();
        emit(HostelsLoadingSucceeded(hostels));

      } else{
        emit(HostelsLoadingFailed(response.statusMessage));
      }
    } catch(e){
      emit(HostelsLoadingFailed(e.toString()));
    }
  }

 }
