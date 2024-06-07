import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub_mobile_app/cubit/user_login/user_login_cubit.dart';
import 'package:hostel_hub_mobile_app/services/auth_service.dart';
import 'package:hostel_hub_mobile_app/pages/homepage.dart';
import 'package:hostel_hub_mobile_app/pages/sign_up_page.dart';
import 'package:hostel_hub_mobile_app/utilities/dialog_helper.dart';
import 'package:hostel_hub_mobile_app/utilities/my_navigator.dart';

import '../data/app_user.dart';

class LoginMobilePage extends StatefulWidget {
  const LoginMobilePage({Key? key}) : super(key: key);

  @override
  State<LoginMobilePage> createState() => _LoginMobilePageState();
}

class _LoginMobilePageState extends State<LoginMobilePage> {
  bool _progressDialogShowing = false;

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery. of(context). size. width ;
    double screenHeight = MediaQuery. of(context). size. height;
    return
      // BlocListener<UserLoginCubit, UserLoginState>(
      // listener: (context, state) {
      //   if(state is UserLoginSucceeded || state is UserLoginFailed) {
      //     if(_progressDialogShowing) {
      //       Navigator.of(context, rootNavigator: true).pop();
      //       _progressDialogShowing = false;
      //     }
      //
      //     if (state is UserLoginSucceeded) {
      //
      //       Navigator.pushReplacement(context,
      //           MaterialPageRoute(builder: (context) => MobileHomePage()));
      //
      //       DialogHelper.showSimpleSnackBar(context, "Login Successful");
      //
      //     }
      //     else if (state is UserLoginFailed) {
      //       DialogHelper.showSimpleSnackBar(context, "Incorrect Username or Password");
      //     }
      //
      //   }
      //   else {
      //     DialogHelper.showProgressDialog(context, message: "Processing");
      //     _progressDialogShowing = true;
      //   }
      // },
      // child:
      Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      color: Color.fromRGBO(13, 28, 82, 1),
                      height: 340,
                      width: screenWidth,
                    ),
                    Positioned(
                      top: -140,
                      left: -140,
                      child: Container(
                        height: 500,
                        width: 500,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(21, 37, 52, 1)
                        ),
                      ),
                    ),

                    Positioned(
                      top: -80,
                      left: -120,
                      child: Container(
                        height: 350,
                        width: 350,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(30, 46, 61, 1)
                        ),
                      ),
                    ),
                    Positioned(
                        top: screenHeight*0.21,
                        left: 24,
                        child: Text("Sign in to your \nAccount", style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 40),)),

                    Positioned(
                        top: screenHeight*0.33,
                        left: 24,
                        child: Text("This wont take long!", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 18),)),

                    // Positioned(
                    //     top: screenHeight*0.04,
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(16.0),
                    //       child: InkWell(
                    //           onTap:() =>  Navigator.pop(context),
                    //           child: Container(width: 30, height: 30, child: Icon(CupertinoIcons.back, color: Colors.white, size: 32,))),
                    //     ))
                  ],
                ),


                      Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16),
                      child: Text("Username", style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 17),),
                      ),

                      Padding(
                      padding: const EdgeInsets.only(top: 8, left:16.0, right: 16),
                      child: TextField(
                      cursorColor: Colors.black12,
                      controller: userNameController,
                      decoration: InputDecoration(
                      hintText: "Enter username",
                      border:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                      color: Colors.black
                      )
                      ),
                      disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                      color: Colors.black
                      )
                      ),
                      enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                      color: Colors.black
                      )
                      ),
                      focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                      color: Colors.black
                      )
                      ),
                      ),
                      ),
                      ),

                      Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16),
                      child: Text("Password", style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 17),),
                      ),

                      Padding(
                      padding: const EdgeInsets.only(top: 8, left:16.0, right: 16),
                      child: TextField(
                      controller: passwordController,
                      obscureText: _obscureText,
                      enableSuggestions: false,
                      autocorrect: false,
                      cursorColor: Colors.black12,
                      decoration: InputDecoration(
                      suffixIcon: IconButton(
                      icon: _obscureText ? Icon(Icons.visibility_off_rounded, color: Colors.black,) :
                      Icon(Icons.visibility, color: Colors.black,),
                      onPressed: (){
                      _toggle();
                      },) ,
                      hintText: "Enter password",
                      border:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                      color: Colors.black
                      )
                      ),
                      disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                      color: Colors.black
                      )
                      ),
                      enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                      color: Colors.black
                      )
                      ),
                      focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                      color: Colors.black
                      )
                      ),
                      ),
                      ),
                      ),



                      Padding(
                      padding: const EdgeInsets.only(left: 16.0, right:16, top:30),
                      child: InkWell(

                        // onTap: () async{
                        //   DialogHelper.showProgressDialog(context, message: "Logging in...");
                        //   try{
                        //     await FirebaseAuth.instance.signInWithEmailAndPassword(
                        //         email: userNameController.text,
                        //         password: passwordController.text);
                        //     Navigator.pop(context);
                        //   } on FirebaseAuthException  catch(e){
                        //       if(e.code == "user-not-found"){
                        //         Navigator.pop(context);
                        //         DialogHelper.showSimpleSnackBar(context, "No user found with that email");
                        //       } else if(e.code == "wrong-password"){
                        //         Navigator.pop(context);
                        //         DialogHelper.showSimpleSnackBar(context, "Incorrect password, try again");
                        //       }else if(e.code == "invalid-email"){
                        //         Navigator.pop(context);
                        //         DialogHelper.showSimpleSnackBar(context, "Invalid email, try again");
                        //       } else if(e.code == "invalid-credential"){
                        //         Navigator.pop(context);
                        //         DialogHelper.showSimpleSnackBar(context, "Invalid username or password, try again");
                        //       }
                        //   }
                        //   // Navigator.pop(context);
                        // },
                      onTap: () async {
                      AppUser user = AppUser(username: userNameController.text, password: passwordController.text, firstname: "", othernames: "");
                      await BlocProvider.of<UserLoginCubit>(context).UserLogin(user);
                      Navigator.pop(context);


                      },
                      child: Container(
                      height: 60,
                      width: screenWidth,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                      color: Color.fromRGBO(12, 232, 98, 1),
                      borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text("Sign In", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),),
                      ),
                      ),
                      ),


                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Container(
                       width: screenWidth*0.3,
                       height: 1,
                       color: Colors.grey,
                     ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text("Or continue with", style: GoogleFonts.roboto(),),
                      ),

                      Container(
                        width: screenWidth*0.3,
                        height: 1,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.2)
                          ),
                          child: Image.asset("assets/googleLogo.png"),
                        ),
                        onTap: () {
                          DialogHelper.showProgressDialog(context, message: "Signing in with google");
                          AuthService().signInWithGoogle();
                          Navigator.pop(context);
                        }

                      ),

                      SizedBox(
                        width: 30,
                      ),

                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.2)
                        ),
                        child: Image.asset("assets/appleLogo.png"),

                      )
                    ],
                  ),
                ),

                // Spacer(),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ", style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 17,)),
                      InkWell(
                        onTap: (){
                          MyNavigator.navigateTo(context, SignUpMobilePage());
                        },
                        child: Text("Register", style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 17, color: Color.fromRGBO(12, 232, 98, 1))),
                      )
                    ],
                  ),
                ),


// ),
              ],
            ),
          ),
        )
      // ),
    );

  }

  void _onSearchButtonPressed() {

  }
}

//
