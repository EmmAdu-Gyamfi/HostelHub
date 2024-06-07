import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostel_hub_mobile_app/cubit/delete_hostel_photo/delete_hostel_photo_cubit.dart';
import 'package:hostel_hub_mobile_app/cubit/edit_hostel/edit_hostel_cubit.dart';
import 'package:hostel_hub_mobile_app/cubit/edit_room/edit_room_cubit.dart';
import 'package:hostel_hub_mobile_app/cubit/get_hostel/get_hostels_cubit.dart';
import 'package:hostel_hub_mobile_app/cubit/get_hostel_reviews/get_hostel_reviews_cubit.dart';
import 'package:hostel_hub_mobile_app/pages/auth_page.dart';

import 'package:hostel_hub_mobile_app/pages/homepage.dart';
import 'package:hostel_hub_mobile_app/pages/login_page.dart';
import 'package:hostel_hub_mobile_app/pages/sign_up_page.dart';
import 'package:hostel_hub_mobile_app/pages/splash_screen.dart';
import 'package:hostel_hub_mobile_app/pages/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/add_hostel/add_hostel_cubit.dart';
import '../cubit/add_hostel_review/add_hostel_review_cubit.dart';
import '../cubit/add_hostel_room/add_hostel_room_cubit.dart';

import '../cubit/add_user/add_user_cubit.dart';
import '../cubit/delete_room_photo/delete_room_photo_cubit.dart';
import '../cubit/filter_params/filter_params_cubit.dart';
import '../cubit/get_hostel/get_hostels_cubit.dart';
import '../cubit/get_hostel_photos/hostel_photos_cubit.dart';
import '../cubit/get_room_photos/get_room_photos_cubit.dart';
import '../cubit/search_hostel/search_hostel_cubit.dart';
import '../cubit/upload_hostel_photo/upload_hostel_photo_cubit.dart';
import '../cubit/upload_room_photo/upload_room_photo_cubit.dart';
import '../cubit/user_login/user_login_cubit.dart';
import '../utilities/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  runApp(MyApp(token: token,));
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({super.key, this.token});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetHostelsCubit>(create: (context) => GetHostelsCubit()),

        BlocProvider<HostelPhotosCubit>(create: (context) => HostelPhotosCubit()),

        BlocProvider<UploadHostelPhotoCubit>(create: (context) => UploadHostelPhotoCubit()),

        BlocProvider<AddHostelRoomCubit>(create: (context) => AddHostelRoomCubit()),

        BlocProvider<AddHostelCubit>(create: (context) => AddHostelCubit()),

        BlocProvider<GetRoomPhotosCubit>(create: (context) => GetRoomPhotosCubit()),

        BlocProvider<UploadRoomPhotoCubit>(create: (context) => UploadRoomPhotoCubit()),

        BlocProvider<SearchHostelCubit>(create: (context) => SearchHostelCubit()),

        BlocProvider<FilterParamsCubit>(create: (context) => FilterParamsCubit()),

        BlocProvider<AddUserCubit>(create: (context) => AddUserCubit()),

        BlocProvider<UserLoginCubit>(create: (context) => UserLoginCubit()),

        BlocProvider<GetHostelReviewsCubit>(create: (context) => GetHostelReviewsCubit()),

        BlocProvider<AddHostelReviewCubit>(create: (context) => AddHostelReviewCubit()),

        BlocProvider<EditHostelCubit>(create: (context) => EditHostelCubit()),

        BlocProvider<DeleteHostelPhotoCubit>(create: (context) => DeleteHostelPhotoCubit()),

        BlocProvider<EditRoomCubit>(create: (context) => EditRoomCubit()),

        BlocProvider<DeleteRoomPhotoCubit>(create: (context) => DeleteRoomPhotoCubit()),











      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blueGrey,
        ),
        home:  AuthPage()
      ),
    );


  }

}



