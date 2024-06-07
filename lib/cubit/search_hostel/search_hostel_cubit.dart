import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/hostel.dart';
import '../../utilities/utils.dart';

part 'search_hostel_state.dart';

class SearchHostelCubit extends Cubit<SearchHostelState> {
  SearchHostelCubit() : super(SearchHostelInitial());

  final _dio = Dio();

  Future<void> searchHostels(String searchString) async{
    // var token = await getToken() ?? '';

    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');


    // FlutterSecureStorage storage = FlutterSecureStorage();
    // // var cUser = 'current_user';
    // final user = jsonDecode(await storage.read(key: 'current_user').toString());
    // try{
    //   emit(SearchHostelLoadingInProgress());
      // var url = Uri.parse("$baseUrl/hostel/search/$searchString");
      if(searchString.isEmpty){
        searchString = " ";

        try{
          emit(SearchHostelLoadingInProgress());
          // String accessToken = token;
          var options = Options(
              headers: {

                "Authorization": "Bearer $token",
                "Accept": "application/json",
                "content-type":"application/json",
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Methods": "GET,POST,PUT,DELETE,OPTIONS"
              }
          );
          var response = await _dio.get("$baseUrl/hostel/search/$searchString", options: options);
          if(response.statusCode == 200){
            Iterable list = await jsonDecode(jsonEncode(response.data)) ;
            List<Hostel> hostels = list.map((e) => Hostel.fromJson(e)).toList();
            emit(SearchHostelLoadingSucceeded(hostels));

          } else{
            emit(SearchHostelLoadingFailed(response.statusMessage));
          }
        }
        catch(e){
          emit(SearchHostelLoadingFailed(e.toString()));

      }


        // var token = user["token"];


        var options = Options(
            headers: {
              "Authorization": "Bearer $token",
              "Accept": "application/json",
              "content-type":"application/json",
              "Access-Control-Allow-Origin": "*",
              "Access-Control-Allow-Methods": "GET,POST,PUT,DELETE,OPTIONS"
            }
        );
      var response = await _dio.get("$baseUrl/hostel/search/$searchString", options: options);

      if(response.statusCode == 200){
        Iterable list = await jsonDecode(jsonEncode(response.data)) ;
        List<Hostel> hostels = list.map((e) => Hostel.fromJson(e)).toList();
        emit(SearchHostelLoadingSucceeded(hostels));

      } else{
        emit(SearchHostelLoadingFailed(response.statusMessage));
      }
    } else{
        try{
          emit(SearchHostelLoadingInProgress());
          var response = await _dio.get("$baseUrl/hostel/search/$searchString", options: Options(

          ));

          if(response.statusCode == 200){
            Iterable list = await jsonDecode(jsonEncode(response.data)) ;
            List<Hostel> hostels = list.map((e) => Hostel.fromJson(e)).toList();
            emit(SearchHostelCompleted(hostels));

          } else{
            emit(SearchHostelLoadingFailed(response.statusMessage));
          }
        }
        catch(e){
          emit(SearchHostelLoadingFailed(e.toString()));

        }

    }
  }


  Future<void> filterHostels(String? region, String? city, int? maxPrice, int? minPrice) async{
    try{
      emit(FilteredHostelResultsLoadingInProgress());
      var options = Options(
          headers: {
            "Accept": "application/json",
            "content-type":"application/json",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "GET,POST,PUT,DELETE,OPTIONS"
          }
      );
      if(minPrice == null){
        minPrice = 0;
      }

      if(maxPrice == null){
        maxPrice = 0;
      }

      var response = await _dio.get("$baseUrl/hostel/filter/$region/$city/$minPrice/$maxPrice", options: options);

      if(response.statusCode == 200){
        Iterable list = await jsonDecode(jsonEncode(response.data)) ;
        List<Hostel> hostels = list.map((e) => Hostel.fromJson(e)).toList();
        emit(FilteredHostelResultsLoadingSucceeded(hostels));

      } else{
        emit(FilteredHostelResultsLoadingFailed(response.statusMessage));
      }
    }
    catch(e){
      emit(FilteredHostelResultsLoadingFailed(e.toString()));

    }
  }


}
