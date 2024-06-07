import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hostel_hub_mobile_app/pages/homepage.dart';
import 'package:hostel_hub_mobile_app/pages/login_page.dart';
import 'package:hostel_hub_mobile_app/pages/welcome_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
        //   User is logged in
          if(snapshot.hasData){
            return MobileHomePage();
          }
          //   User is Not logged in
          else{
            // return LoginMobilePage();
            return MobileHomePage();
          }


        },
      ),
    );
  }
}
