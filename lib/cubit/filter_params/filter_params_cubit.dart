import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';


import '../../data/hostel.dart';
import '../../utilities/utils.dart';

part 'filter_params_state.dart';

class FilterParamsCubit extends Cubit<FilterParamsState> {
  FilterParamsCubit() : super(LoadingFilterParamsInitial());

  final _dio = Dio();

  Future<void> loadFilterParams() async{
    try{
      emit(LoadingFilterParamsInProgress());
      var options = Options(
          headers: {
            "Accept": "application/json",
            "content-type":"application/json",
            "Access-Control-Allow-Origin": "*"
          }
      );

      var response = await _dio.get("$baseUrl/hostel/filterparams", options: options);

      if(response.statusCode == 200){
        var data = await jsonDecode(jsonEncode(response.data)) ;
        FilterParams filterParams =  FilterParams.fromJson(data);
        emit(LoadingFilterParamsSucceeded(filterParams));

      } else{
        emit(LoadingFilterParamsFailed(response.statusMessage));
      }
    } catch(e){
      emit(LoadingFilterParamsFailed(e.toString()));
    }
  }
}
