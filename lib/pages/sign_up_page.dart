import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub_mobile_app/cubit/add_user/add_user_cubit.dart';
import 'package:hostel_hub_mobile_app/data/app_user.dart';
import 'package:hostel_hub_mobile_app/pages/homepage.dart';
import 'package:hostel_hub_mobile_app/pages/login_page.dart';
import 'package:hostel_hub_mobile_app/utilities/dialog_helper.dart';

import '../cubit/user_login/user_login_cubit.dart';
import '../services/auth_service.dart';
import '../utilities/my_navigator.dart';

class SignUpMobilePage extends StatefulWidget {
  const SignUpMobilePage({Key? key}) : super(key: key);

  @override
  State<SignUpMobilePage> createState() => _SignUpMobilePageState();
}

class _SignUpMobilePageState extends State<SignUpMobilePage> {
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  bool _progressDialogShowing = false;
  bool _obscureConfirmPassword = true;

  // void _toggleConfirmPassword() {
  //   setState(() {
  //     _obscureConfirmPassword = !_obscureConfirmPassword;
  //   });
  // }

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
      // _obscureConfirmText = !_obscureConfirmText;
    });
  }

  void _toggleConfirmPassword() {
    setState(() {
      // _obscureText = !_obscureText;
      _obscureConfirmText = !_obscureConfirmText;
    });
  }


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController? firstNameController = TextEditingController();
  TextEditingController? otherNamesController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery. of(context). size. width ;
    double screenHeight = MediaQuery. of(context). size. height;
    return
      // BlocListener<AddUserCubit, AddUserState>(
      // listener: (context, state) async {
      //   if(state is AddUserSucceeded || state is AddUserFailed) {
      //     if(_progressDialogShowing) {
      //       Navigator.of(context, rootNavigator: true).pop();
      //       _progressDialogShowing = false;
      //     }
      //     if (state is AddUserSucceeded) {
      //       // DialogHelper.showSimpleSnackBar(context, "Sign-up Successful");
      //       // MyNavigator.navigateTo(
      //       //     context, MobileHomePage());
      //
      //       AppUser user = AppUser(username: userNameController.text, password: passwordController.text, firstname: firstNameController?.text, othernames: otherNamesController?.text);
      //       await BlocProvider.of<UserLoginCubit>(context).UserLogin(user);
      //       Navigator.pushReplacement(context,
      //           MaterialPageRoute(builder: (context) => MobileHomePage()));
      //       DialogHelper.showSimpleSnackBar(context, "Sign-up Successful");
      //
      //     } else if (state is AddUserFailed) {
      //       DialogHelper.showSimpleSnackBar(context, "Both fields are required");
      //     }
      //   } else {
      //     DialogHelper.showProgressDialog(context, message: "processing...");
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
                        child: Text("Create an \nAccount", style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 40),)),

                    Positioned(
                        top: screenHeight*0.33,
                        left: 24,
                        child: Text("Welcome aboard, this won't take long!", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16),)),

                    Positioned(
                        top: screenHeight*0.04,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                              onTap:() =>  Navigator.pop(context),
                              child: Container(width: 30, height: 30, child: Icon(CupertinoIcons.back, color: Colors.white, size: 32,))),
                        ))
                  ],
                ),

                // Padding(
                //   padding: const EdgeInsets.only(left: 16.0, top: 16),
                //   child: Text("Firstname", style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 17),),
                // ),
                //
                // Padding(
                //   padding: const EdgeInsets.only(top: 8, left:16.0, right: 16),
                //   child: TextField(
                //     cursorColor: Colors.black12,
                //     controller: firstNameController,
                //     decoration: InputDecoration(
                //       hintText: "Enter firstname",
                //       border:  OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10),
                //           borderSide: BorderSide(
                //               color: Colors.black
                //           )
                //       ),
                //       disabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10),
                //           borderSide: BorderSide(
                //               color: Colors.black
                //           )
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10),
                //           borderSide: BorderSide(
                //               color: Colors.black
                //           )
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10),
                //           borderSide: BorderSide(
                //               color: Colors.black
                //           )
                //       ),
                //     ),
                //   ),
                // ),
                //
                // Padding(
                //   padding: const EdgeInsets.only(left: 16.0, top: 16),
                //   child: Text("Othername(s)", style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 17),),
                // ),
                //
                // Padding(
                //   padding: const EdgeInsets.only(top: 8, left:16.0, right: 16),
                //   child: TextField(
                //     cursorColor: Colors.black12,
                //     controller: otherNamesController,
                //     decoration: InputDecoration(
                //       hintText: "Enter othername(s)",
                //       border:  OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10),
                //           borderSide: BorderSide(
                //               color: Colors.black
                //           )
                //       ),
                //       disabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10),
                //           borderSide: BorderSide(
                //               color: Colors.black
                //           )
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10),
                //           borderSide: BorderSide(
                //               color: Colors.black
                //           )
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10),
                //           borderSide: BorderSide(
                //               color: Colors.black
                //           )
                //       ),
                //     ),
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16),
                  child: Text("Email", style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 17),),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8, left:16.0, right: 16),
                  child: TextField(
                    cursorColor: Colors.black12,
                    controller: userNameController,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
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
                          _togglePassword();
                        },) ,
                      hintText: "Enter a password",
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
                  child: Text("Confirm Password", style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 17),),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8, left:16.0, right: 16),
                  child: TextField(
                    controller: confirmPasswordController,
                    obscureText: _obscureConfirmText,
                    enableSuggestions: false,
                    autocorrect: false,
                    cursorColor: Colors.black12,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: _obscureConfirmText ? Icon(Icons.visibility_off_rounded, color: Colors.black,) :
                        Icon(Icons.visibility, color: Colors.black,),
                        onPressed: (){
                          _toggleConfirmPassword();
                        },) ,
                      hintText: "Confirm your password",
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
                    onTap: () async{
                      if(passwordController.text == confirmPasswordController.text){
                        try{
                          DialogHelper.showProgressDialog(context, message: "Creating account...");
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: userNameController.text,
                              password: passwordController.text);
                          Navigator.pop(context);
                          DialogHelper.showSimpleSnackBar(context, "Account created successfully");

                        } on FirebaseAuthException catch(e){
                          Navigator.pop(context);

                          DialogHelper.showSimpleSnackBar(context, "${e.code}");
                        }
                      } else{
                        DialogHelper.showSimpleSnackBar(context, "Passwords do not match");

                      }
                      // AppUser appUser = AppUser(username: userNameController.text, password: passwordController.text, firstname: firstNameController?.text, othernames: otherNamesController?.text);
                      //  BlocProvider.of<AddUserCubit>(context).loadAddUser(appUser);
                    },
                    child: Container(
                      height: 60,
                      width: screenWidth,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(12, 232, 98, 1),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text("Sign up", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),),
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
                      onTap: () => AuthService().signInWithGoogle(),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.2)
                          ),
                          child: Image.asset("assets/googleLogo.png"),
                        ),
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



                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ", style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 17,)),
                      InkWell(
                        onTap: (){
                          MyNavigator.navigateTo(context, LoginMobilePage());
                        },
                        child: Text("SignIn", style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 17, color: Color.fromRGBO(12, 232, 98, 1))),
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

  String? validatePassword(String password) {
    if(password != passwordController.text){
      return "Passwords do not match!!";
    }
    return null;
  }
}