import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../data/app_user.dart';
import '../../utilities/utils.dart';

part 'add_user_state.dart';

class AddUserCubit extends Cubit<AddUserState> {
  AddUserCubit() : super(AddUserInitial());

  final _dio = Dio();

  Future<void> loadAddUser(AppUser appUser) async{
    var url = "$baseUrl/appuser";
    try{
      emit(AddUserInProgress());

      // if(appUser.username == null || appUser.password == null){
      //   emit(AddUserFailed("Opps something went wrong, try again "));
      // }

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
                'firstname': appUser.firstname,
                'othernames': appUser.othernames,
              }
          ));



      if (response.statusCode == 200){
        emit(AddUserSucceeded());
      } else{
        emit(AddUserFailed("Adding User Failed"));
      }
      
    } catch(e){
        emit(AddUserFailed(e.toString()));
    }
  }

}
