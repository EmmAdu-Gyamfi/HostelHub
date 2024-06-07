import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub_mobile_app/pages/room_gallery_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../data/hostel.dart';
import '../utilities/my_navigator.dart';
import '../utilities/utils.dart';

class FourInARoomMobilePage extends StatefulWidget {
  final List<HostelRooms> rooms;
  final String hostelName;

  const FourInARoomMobilePage({Key? key, required this.rooms, required this.hostelName}) : super(key: key);

  @override
  State<FourInARoomMobilePage> createState() => _FourInARoomMobilePageState();
}

class _FourInARoomMobilePageState extends State<FourInARoomMobilePage> {

  late List<HostelRooms> rooms;
  late String hostelName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rooms = widget.rooms;
    hostelName = widget.hostelName;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery. of(context). size. width ;
    double screenHeight = MediaQuery. of(context). size. height;
    var fourinARoom = rooms.where((e) => e.room.roomCategory == "Four In a Room").toList();
    return   Container(
      width: double.infinity,
      height: double.infinity,

      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                primaryColor,
                primaryColor,
                Colors.white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
      child: Stack(
        children: [
          // Positioned(
          //   right: -7,
          //   top: -7,
          //   child: Container(
          //     width: 50,
          //     height: 50,
          //     decoration: BoxDecoration(
          //         color: Color.fromRGBO(212, 224, 242, 0.12),
          //       shape: BoxShape.circle
          //     ),
          //   ),
          // ),

          Positioned(
            right: -45,
            top: -45,
            child: Container(
              width: 125,
              height: 125,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(71, 69, 90, 0.3),
                  shape: BoxShape.circle
              ),
            ),
          ),

          Positioned(
            right: -42,
            top: -42,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle
              ),
            ),
          ),

          Positioned(
            right: -14,
            top: -13,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(30, 46, 61, 1),
                  shape: BoxShape.circle
              ),
            ),
          ),

          Positioned(
            top: 45,
            right: 50,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(30, 46, 61, 1),
                  shape: BoxShape.circle
              ),
            ),
          ),

          // left galaxy

          Positioned(
            left: -45,
            top: 13,
            child: Container(
              width: 125,
              height: 125,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(71, 69, 90, 0.3),
                  shape: BoxShape.circle
              ),
            ),
          ),

          Positioned(
            left: -42.5,
            top: 15,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle
              ),
            ),
          ),

          Positioned(
            left: -15,
            top: 40,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(30, 46, 61, 1),
                  shape: BoxShape.circle
              ),
            ),
          ),

          Positioned(
            top: 60,
            left: 65,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(30, 46, 61, 1),
                  shape: BoxShape.circle
              ),
            ),
          ),

          // backArrow
          Positioned(
            // right: 25,
            top: screenHeight*0.045,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.white, size: 30,),
              ),
            ),
          ),

          Positioned(
            // right: 25,
            top: screenHeight*0.065,
            left: screenWidth*0.32,
            child: Text("Four in a room", style: GoogleFonts.roboto(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
          ),


          Positioned(
            top: screenHeight*0.12,
            child: Container(
              height: screenHeight*0.79,
              width: screenWidth,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(252, 248, 247, 1),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Find your", style: GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 25),),

                    Text(" Desired room", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 25)),

                    fourinARoom.isEmpty ? Container(
                      child:Padding(
                        padding: const EdgeInsets.only(bottom:0.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset("assets/emptyList.png", height: 500, width: 400,),
                                  Positioned(
                                    bottom: 50,
                                    child: Text("No Rooms Found!",
                                      style: GoogleFonts.robotoSlab(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 25,
                                    child: Text("There are no rooms under this category!",
                                      style: GoogleFonts.robotoSlab(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ) : SizedBox(),

                    // Container(
                    //   color: Colors.blue,
                    //   height: screenHeight,
                    //   width: 320,
                    //   child: ListView.builder(
                    //       itemCount: 100,
                    //       itemBuilder: (context, index){
                    //     return Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Container(
                    //         height: 10,
                    //         width: 10,
                    //         color: Colors.red,
                    //       ),
                    //     );
                    //   }),
                    //
                    // )
                    Expanded(
                      child: Center(
                        child: Container(
                          // color: Colors.blue,
                          width: screenWidth,
                          height: screenHeight*3,
                          child: ListView.builder(
                              shrinkWrap: true,

                              itemCount:   fourinARoom.length,
                              itemBuilder: (context, index){
                                if(index%2 == 0){
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0, top: 4),
                                    child: InkWell(
                                      onTap: (){
                                        MyNavigator.navigateTo(context, RoomGalleryMobilePage(photos:   fourinARoom[index].room.roomPhotos));
                                      },
                                      child: Container(
                                        width: 280,
                                        color: Color.fromRGBO(252, 248, 247, 1),
                                        // alignment: Alignment.center,
                                        height: 275
                                        ,
                                        child: Stack(
                                          // alignment: Alignment.center,
                                          children: [
                                            Positioned(

                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 0.0, right: 0,top:0),
                                                child: Container(
                                                  width: screenWidth*0.55,
                                                  height: 270,
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow,
                                                      borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: CachedNetworkImage(
                                                      fadeInDuration: Duration(microseconds: 300),
                                                      fit: BoxFit.fill,
                                                      imageUrl: "$baseUrl/FileStore/${  fourinARoom[index].room.roomPhotos[0].fileId}",
                                                      httpHeaders: {
                                                        "Accept": "application/json",
                                                        "content-type":"application/json"
                                                      },
                                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                                      placeholder: (context, string) => LoadingAnimationWidget.threeArchedCircle(color: Colors.black38, size: 30),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              right: 1,
                                            ),

                                            Positioned(
                                                right: 10,
                                                bottom: 20,
                                                child: Chip(
                                                    label: Text("$hostelName", style: GoogleFonts.robotoCondensed(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                                                    backgroundColor: Colors.white
                                                )
                                            ),

                                            Positioned(
                                              child: Padding(
                                                padding: const EdgeInsets.only( top: 55, left: 1),
                                                child: Container(
                                                  width: screenWidth*0.45,
                                                  height: 170,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black.withOpacity(0.5),
                                                          spreadRadius: 2,
                                                          blurRadius: 3,
                                                          offset: Offset(3, 0), // changes position of shadow
                                                        ),
                                                      ],
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column(

                                                        children: [
                                                          Container(

                                                            child: Text("${fourinARoom[index].room.roomCategory}", style: GoogleFonts.merriweather(fontWeight: FontWeight.bold, fontSize: 18),),
                                                            // color: Colors.pinkAccent,
                                                          ),

                                                          Container(

                                                            child: Text("${  fourinARoom[index].room.roomLabel}", style: GoogleFonts.merriweather(fontWeight: FontWeight.normal, fontSize: 16),),
                                                            // color: Colors.pinkAccent,
                                                          ),

                                                          Container(

                                                            child: Row(
                                                              children: [
                                                                Text("₵${  fourinARoom[index].room.price}", style: GoogleFonts.merriweather(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16),),
                                                                Text(" per/ head", style: GoogleFonts.merriweather(fontWeight: FontWeight.bold,fontSize: 15),),

                                                              ],
                                                            ),
                                                            // color: Colors.pinkAccent,
                                                          ),

                                                          Container(

                                                            child: Text("tap for more images....", style: GoogleFonts.merriweather(fontWeight: FontWeight.normal, fontSize: 15, color: Colors.lightBlue),),
                                                            // color: Colors.pinkAccent,
                                                          ),
                                                        ],
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else{
                                  return InkWell(
                                    onTap: (){
                                      MyNavigator.navigateTo(context, RoomGalleryMobilePage(photos:   fourinARoom[index].room.roomPhotos,));
                                    },
                                    child: Container(
                                      height: 275,
                                      width: 280,
                                      // color: Colors.black87,
                                      child: Stack(
                                        // alignment: Alignment.center,
                                        children: [


                                          Positioned(
                                            child: Padding(
                                              padding: const EdgeInsets.only( top: 0, left: 0, bottom: 0),
                                              child: Container(
                                                width: screenWidth*0.55,
                                                height: 270,
                                                decoration: BoxDecoration(
                                                    color: Colors.pinkAccent,
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    fadeInDuration: Duration(microseconds: 300),
                                                    fit: BoxFit.fill,
                                                    imageUrl: "$baseUrl/FileStore/${  fourinARoom[index].room.roomPhotos[0].fileId}",
                                                    httpHeaders: {
                                                      "Accept": "application/json",
                                                      "content-type":"application/json"
                                                    },
                                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                                    placeholder: (context, string) => LoadingAnimationWidget.threeArchedCircle(color: Colors.black38, size: 30),
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ),

                                          Positioned(
                                              left: 10,
                                              bottom: 20,
                                              child: Chip(
                                                  label: Text("$hostelName", style: GoogleFonts.robotoCondensed(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                                                  backgroundColor: Colors.white
                                              )
                                          ),

                                          Positioned(

                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 0.0, right: 0,top: 55,),
                                              child: Container(
                                                width: screenWidth*0.45,
                                                height: 170,
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black.withOpacity(0.5),
                                                        spreadRadius: 2,
                                                        blurRadius: 3,
                                                        offset: Offset(0, 3), // changes position of shadow
                                                      ),
                                                    ],
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(

                                                      children: [
                                                        Container(

                                                          child: Text("${  fourinARoom[index].room.roomCategory}", style: GoogleFonts.merriweather(fontWeight: FontWeight.bold, fontSize: 18),),
                                                          // color: Colors.pinkAccent,
                                                        ),

                                                        Container(

                                                          child: Text("${  fourinARoom[index].room.roomLabel}", style: GoogleFonts.merriweather(fontWeight: FontWeight.normal, fontSize: 16),),
                                                          // color: Colors.pinkAccent,
                                                        ),

                                                        Container(

                                                          child: Row(
                                                            children: [
                                                              Text("₵${  fourinARoom[index].room.price}", style: GoogleFonts.merriweather(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16),),
                                                              Text(" per/ head", style: GoogleFonts.merriweather(fontWeight: FontWeight.bold,fontSize: 15),),

                                                            ],
                                                          ),
                                                          // color: Colors.pinkAccent,
                                                        ),

                                                        Container(

                                                          child: Text("tap for more images....", style: GoogleFonts.merriweather(fontWeight: FontWeight.normal, fontSize: 15, color: Colors.lightBlue),),
                                                          // color: Colors.pinkAccent,
                                                        ),
                                                      ],
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            right: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return Text("");
                              }),
                        ),
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(top:0.0),
                    //   child: Container(
                    //     width: screenWidth,
                    //     height: 70,
                    //     color: Colors.red,
                    //   ),
                    // )

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
