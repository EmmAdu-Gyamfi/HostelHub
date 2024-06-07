import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub_mobile_app/pages/login_page.dart';
import 'package:hostel_hub_mobile_app/pages/sign_up_page.dart';
import 'package:hostel_hub_mobile_app/utilities/my_navigator.dart';
import 'package:hostel_hub_mobile_app/utilities/utils.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery. of(context). size. width ;
    double screenHeight = MediaQuery. of(context). size. height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
              height: screenHeight*0.28,
            ),

            Image.asset(
                "assets/hostelLogo.png",
              height: screenHeight*0.18,
              width: screenWidth*0.4,
            ),


                  Text(("Hostel Hub"),style: GoogleFonts.merriweather(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
                  // TyperAnimatedText(("Hostel Hub"),textStyle: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),,)


            Spacer(),

            Container(
              width: double.infinity,
              height: screenHeight*0.25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: DefaultTextStyle(child: Text("Welcome"),style: GoogleFonts.poppins(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: DefaultTextStyle(child: Text("Get started with your account"),style: GoogleFonts.roboto(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal)),
                  ),

                  InkWell(
                    onTap: (){
                      MyNavigator.navigateTo(context, LoginMobilePage());
                    },
                    child: Container(
                      width: screenWidth*0.6,
                      height: screenHeight*0.05,
                      decoration: BoxDecoration(
                        color: primaryColor,

                        borderRadius: BorderRadius.circular(10)
                      ),
                      alignment: Alignment.center,
                      child: DefaultTextStyle(child: Text("Tap to Log In"),style: GoogleFonts.roboto(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),

                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: InkWell(
                      onTap: (){
                        MyNavigator.navigateTo(context, SignUpMobilePage());
                      },
                      child: Container(
                        width: screenWidth*0.6,
                        height: screenHeight*0.05,
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        alignment: Alignment.center,
                        child: DefaultTextStyle(child: Text("Create an Account"),style: GoogleFonts.roboto(color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold)),

                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
