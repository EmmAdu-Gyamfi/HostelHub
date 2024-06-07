import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hostel_hub_mobile_app/data/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/app_user.dart';
import '../../pages/homepage.dart';
import '../../utilities/my_navigator.dart';
import '../../utilities/utils.dart';
import '../search_hostel/search_hostel_cubit.dart';

part 'user_login_state.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit() : super(UserLoginInitial());

  final _dio = Dio();
  Future<void> UserLogin (AppUser appUser) async{
    var url = "$baseUrl/appuser/authorize";
    try{
      emit(UserLoginInProgress());

      var options = Options(
          headers: {
            "Accept": "application/json",
            "content-type":"application/json",
            "Access-Control-Allow-Origin": "*"
          }
      );

      var response = await _dio.post(
          url,
          options: options,
          data: jsonEncode(
              {
                'username': appUser.username,
                'password': appUser.password,
              }
          ));

      if (response.statusCode == 200){
        // Iterable results = await jsonDecode(jsonEncode(response.data)) ;
        AppUser user = AppUser.fromJson(response.data);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', '${user.token}');
        prefs.setString('userName', '${user.username}');
        prefs.setString('userId', '${user.userId}');


        // await storage.write(key: "token", value: "${user.token}");


        emit(UserLoginSucceeded(user));
      } else{
        emit(UserLoginFailed("Adding User Failed"));
      }

    } catch(e){
      emit(UserLoginFailed(e.toString()));
    }
  }
  }

