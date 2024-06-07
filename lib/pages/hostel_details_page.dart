import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub_mobile_app/pages/view_room_page.dart';
import 'package:hostel_hub_mobile_app/utilities/my_navigator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/hostel.dart';
import '../utilities/utils.dart';
import 'feedback_page.dart';

class HostelDetailsMobilePage extends StatefulWidget {
  final Hostel hostel;
  const HostelDetailsMobilePage({Key? key, required this.hostel}) : super(key: key);

  @override
  State<HostelDetailsMobilePage> createState() => _HostelDetailsMobilePageState();
}

class _HostelDetailsMobilePageState extends State<HostelDetailsMobilePage> {
  bool showFab = true;

  late Hostel hostel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hostel = widget.hostel;
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery. of(context). size. width ;
    double screenHeight = MediaQuery. of(context). size. height;
    return Scaffold(
      floatingActionButton: showFab ? FloatingActionButton.extended(
        onPressed: (){

          // MyNavigator.navigateTo(context, AddFeedBackPage()));
        },
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        icon: Icon(Icons.edit_calendar),
        label: Text("Book a Room", style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),),

      ): null,
      backgroundColor: Color.fromRGBO(206, 207, 217, 1),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification){
          setState(() {
            if(notification.direction == ScrollDirection.forward){
              showFab = true;
            } else if(notification.direction == ScrollDirection.reverse){
              showFab = false;
            }
          });
          return true;
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Stack(
              children: [
                Container(
                  height: screenHeight*0.42,
                  child: ClipRRect(
                    // borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),

                        // decoration: BoxDecoration(
                        //    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                        // ),
                        child: ImageSlideshow(
                          isLoop: true,
                          indicatorBackgroundColor: Colors.transparent,
                          indicatorColor: Colors.transparent,
                          children: _getImages(),
                        ),
                      ),
                ),



          Positioned(
            bottom: 8,
            left: 16,
            child: Row(
              children: [
                Container(
                  color: Colors.black,
                  child: Row(
                      children: [
                        Text("${hostel.hostelPhotos.length} ", style: GoogleFonts.roboto(color: Colors.white),),
                        Icon(CupertinoIcons.camera_fill, color: Colors.white, size: 16,),

                      ],
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Icon(Icons.location_on_outlined, color: Colors.white, size: 18),
                SizedBox(
                  width: 2,
                ),
                Text("${hostel.locality}, ${hostel.city}, ${hostel.region}.", style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.normal,fontSize: 15)),

              ],
            ),
          ),

          Positioned(
                    right: 0,
                    top: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          shape: BoxShape.circle,

                        ),
                        child: Icon(Icons.favorite, color: Colors.red,),
                      ),
                    ),
                  ),

                  Positioned(
                    // right: 25,
                    top: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.circle,
                              color: Colors.white
                          ),
                          child: Icon(Icons.arrow_back, color: primaryColor,size: 28,),
                        ),
                      ),
                    ),
                  ),

                // Positioned(
                //   right: 0,
                //   bottom: 0,
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: InkWell(
                //       onTap: (){
                //         Navigator.pop(context);
                //       },
                //       child: Container(
                //         height: 35,
                //         width: 35,
                //         decoration: BoxDecoration(
                //           shape: BoxShape.circle,
                //             // borderRadius: BorderRadius.circular(10),
                //             color: Colors.blue
                //         ),
                //         child: Icon(Icons.comment, color: Colors.white,),
                //
                //       ),
                //     ),
                //   ),
                // ),

              ],
            ),


              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                      child: Row(
                        children: [
                          Text(hostel.name,style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 24),),
                          Spacer(),
                          Container(
                              height: 25,
                              width: 30,
                              // color: Colors.green,
                              child: Icon(Icons.chat_outlined, color: Colors.green, size: 26,))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Row(
                          children: [
                            Icon(Icons.share_location_outlined, color: Colors.blue, size: 18),
                            SizedBox(
                              width: 2,
                            ),
                            Text("GPS Address: ", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 16)),
                            Text("${hostel.address}.", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 16)),
                          ],
                        ),
                      ),
                    ),

                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                            onTap: (){
                              MyNavigator.navigateTo(context, ViewRoomMobilePage(rooms: hostel.hostelRooms, hostelName:hostel.name));
                            },
                            child: Container(
                              width: screenWidth*0.4,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                    color: primaryColor
                                  ),
                                  left: BorderSide(
                                      color: primaryColor
                                  ),
                                  right: BorderSide(
                                      color: primaryColor
                                  ),
                                  top: BorderSide(
                                      color: primaryColor
                                  ),
                                )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 3.0),
                                    child: Icon(Icons.bed_rounded, color: primaryColor,size: 24,),
                                  ),
                                  Text("View Rooms", style: GoogleFonts.roboto(color: primaryColor, fontWeight: FontWeight.bold,fontSize: 18))
                                ],
                              ),
                            ),
                          ),
                        ),

                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                            onTap: (){
                              _makePhoneCall(hostel.phoneNumber);
                            },
                            child: Container(
                              width: screenWidth*0.4,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: primaryColor
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 3.0),
                                    child: Icon(Icons.phone_in_talk, color: Colors.white, size: 28,),
                                  ),
                                  Text("Call", style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20))
                                ],
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                  ],
                )
              ),

              SizedBox(height: 8,),

              // Icon(Icons.star_rate_rounded, color: Colors.orange, size: 20,),
              // Text("7.5", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 14))

                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2,),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                          child: Text("Description", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 20)),
                        ),

                        SizedBox(height: 1,),


                        Padding(
                          padding: const EdgeInsets.only(top: 0.0, left: 16, right: 16),
                          child: Text("${hostel.description}", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 16)),
                        ),
                        SizedBox(height: 4,),
                      ],
                    ),
                  ),

              SizedBox(height: 8,),

              Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4,),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                          child: Row(
                            children: [
                              Text("Minimum rent time", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16)),
                              Spacer(),
                              Text("${hostel.minimumRentTime} year(s)", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 16))
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                          child: Row(
                            children: [
                              Text("Condition", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16)),
                              Spacer(),
                              Text("${hostel.condition}", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 16))
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                          child: Row(
                            children: [
                              Text("Furnishing", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16)),
                              Spacer(),
                              Text("${hostel.furnishing}", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 16))
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                          child: Row(
                            children: [
                              Text("Wi-Fi", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16)),
                              Spacer(),
                              Text("${hostel.wiFi}", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 16))
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                          child: Row(
                            children: [
                              Text("Laundry Services", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16)),
                              Spacer(),
                              Text("${hostel.laundryServices}", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 16))
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                          child: Row(
                            children: [
                              Text("Study room", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16)),
                              Spacer(),
                              Text("${hostel.studyRoom}", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 16))
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                          child: Row(
                            children: [
                              Text("Security", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16)),
                              Spacer(),
                              Text("${hostel.security}", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 16))
                            ],
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                          child: Row(
                            children: [
                              Text("Negotiation", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16)),
                              Spacer(),
                              hostel.negotiation ? Text("Not allowed", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 16)) :
                              Text("Allowed", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 16))
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                          child: Row(
                            children: [
                              Text("Phone number", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16)),
                              Spacer(),
                              Text("${hostel.phoneNumber}", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 16))
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                          child: Row(
                            children: [
                              Text("Alternate phone number", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16)),
                              Spacer(),
                              Text("${hostel.alternativePhoneNumber}", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 16))
                            ],
                          ),
                        ),
                        SizedBox(height: 6,),

                      ],
                    ),
                  ),

              SizedBox(height: 8,),

              // Container(
              //   color: Colors.white,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text("Start chat with manager", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 17),),
              //         Row(
              //           children: [
              //             Chip(label: Text("Hello", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16, color: primaryColor),), backgroundColor: Colors.white, side: BorderSide(color: primaryColor),),
              //             Chip(label: Text(, style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16, color: primaryColor),), backgroundColor: Colors.white, side: BorderSide(color: primaryColor),),
              //
              //           ],
              //         )
              //       ],
              //     ),
              //   ),
              // )

              Container(
                // height: screenHeight*0.06,
                // width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    // Text("aasd"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          MyNavigator.navigateTo(context, FeedbackPage(hostel: hostel,));
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              // border: Border(
                              //     bottom: BorderSide(
                              //         color: Colors.yellow,
                              //         width: 4
                              //     ),
                              //   right: BorderSide(
                              //       color: Colors.yellow,
                              //       width: 4
                              //   ),
                              //   left: BorderSide(
                              //       color: Colors.yellow,
                              //       width: 4
                              //   ),
                              //   top: BorderSide(
                              //       color: Colors.yellow,
                              //     width: 4
                              //   ),
                              //
                              // )
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.forum, color: Colors.white,),
                              SizedBox(width: 8,),
                              Text("Read Feedbacks", style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

        ),
      ),
    );
  }

  List<Container> _getImages() {
    var images = hostel.hostelPhotos.map((e) => Container(

      child: Stack(
        children: [
          Container(
            height: 400,
            child: CachedNetworkImage(
              fadeInDuration: Duration(microseconds: 0),
              useOldImageOnUrlChange: true,

              fit: BoxFit.fill,
              width: double.infinity,
              imageUrl: "$baseUrl/FileStore/${e.fileId}",
              httpHeaders: {
                "Accept": "application/json",
                "content-type":"application/json"
              },
              errorWidget: (context, url, error) => Icon(Icons.error),
              placeholder: (context, string) => Container(color: Colors.grey,child: LoadingAnimationWidget.threeArchedCircle(color: Colors.white, size: 30)),
            ),
          ),

          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.9),
                      Colors.transparent,
                      Colors.transparent
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter
                )
            ),
          )
        ],
      ),
    ),).toList();
    return images;
  }

  Future<void> _makePhoneCall(String url) async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: url,
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
}
}
