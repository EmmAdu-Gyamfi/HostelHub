import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';

import '../../data/hostel.dart';


part 'edit_hostel_state.dart';

class EditHostelCubit extends Cubit<EditHostelState> {
  EditHostelCubit() : super(EditHostelInitial());

  final _dio = Dio();


  Future<void> putHostel(Hostel hostel) async {
    var url = Uri.parse("https://10.0.2.2:5001/api/hostel/${hostel.hostelId}");
    try{
      emit(EditHostelInProgress());
      // var parsedDate = DateTime.parse(dueDate!);
      var response = await http.put(url, headers: {
        "Accept": "application/json",
        "content-type":"application/json"
      }, body: jsonEncode({
        'name': hostel.name,
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
        'wiFi' : hostel.wiFi,}));
      if(response.statusCode == 204) {
        // loadTodoItem();
        emit(EditHostelSucceeded());
      } else {
        emit(EditHostelFailed(response.reasonPhrase));
      }
    } catch (e){
      emit(EditHostelFailed(e.toString()));
    }
  }

}
