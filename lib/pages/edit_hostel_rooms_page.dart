import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub_mobile_app/pages/add_hostel_room_page.dart';
import 'package:hostel_hub_mobile_app/pages/edit_room_page.dart';
import 'package:hostel_hub_mobile_app/utilities/my_navigator.dart';
import 'package:hostel_hub_mobile_app/utilities/utils.dart';

import '../data/hostel.dart';
import '../utilities/custom_icons_icons.dart';

class EditHostelRoomPage extends StatefulWidget {
  final Hostel hostel;
   EditHostelRoomPage({super.key, required this.hostel});

  @override
  State<EditHostelRoomPage> createState() => _EditHostelRoomPageState();
}

class _EditHostelRoomPageState extends State<EditHostelRoomPage> {
  @override
  Widget build(BuildContext context) {
    // List<String> words = ["ada","ada","ada","ada","ada","ada","ada"];
    List<HostelRooms> oneInaRoom = widget.hostel.hostelRooms.where((element) => element.room.roomCategory == "One In a Room").toList();
    List<HostelRooms> twoInaRoom = widget.hostel.hostelRooms.where((element) => element.room.roomCategory == "Two In a Room").toList();
    List<HostelRooms> threeInaRoom = widget.hostel.hostelRooms.where((element) => element.room.roomCategory == "Three In a Room").toList();
    List<HostelRooms> fourInaRoom = widget.hostel.hostelRooms.where((element) => element.room.roomCategory == "Four In a Room").toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);

          Navigator.push(context, MaterialPageRoute(builder: (context) => AddHostelRoomMobilePage(hostelId: widget.hostel.hostelId)));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        icon: Icon(Icons.add, size: 30),
        backgroundColor:  primaryColor, label: Text("Add Room", style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold), ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          // color: Colors.red,
          child: SingleChildScrollView(
            child:  Column(
              children: [
                oneInaRoom.isNotEmpty ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("One in a Room", style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Icon(CupertinoIcons.person_fill),
                        )

                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.black38,
                    ),

                    Wrap(
                      spacing: 2,
                      children: oneInaRoom.map((e) => InkWell(
                        onTap: (){
                          MyNavigator.navigateTo(context, EditRoomPage(room: e.room));
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          margin: EdgeInsets.only(left: 6, right: 6,top: 6),
                          // height: 70,
                          width: 110,
                          // color: Colors.red,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                           color: primaryColor
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(child: Text("${e.room.roomLabel}", style: GoogleFonts.poppins(fontSize: 14,color: Colors.white, fontWeight: FontWeight.bold),)),
                              Divider(color: Colors.white, thickness: 1,),
                              Center(child: Text("GH¢ ${e.room.price}", style: GoogleFonts.poppins(fontSize: 15,color: Colors.white, fontWeight: FontWeight.bold),))
                            ],
                          ),
                        ),
                      )
                      ).toList(),
                    )
                  ],
                ): Text(""),

                 twoInaRoom.isNotEmpty ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: [
              Text("Two in a Room", style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Icon(CupertinoIcons.person_2_fill),
              )
            ],
          ),
        ),
      Divider(
        thickness: 1,
        color: Colors.black38,
      ),

      Wrap(
        spacing: 2,
        children: twoInaRoom.map((e) => InkWell(
          onTap: (){
            MyNavigator.navigateTo(context, EditRoomPage(room: e.room));
          },
          child: Container(
            padding: EdgeInsets.all(6),
            margin: EdgeInsets.only(left: 6, right: 6,top: 6),
            // height: 70,
            width: 110,
            // color: Colors.red,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryColor
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("${e.room.roomLabel}", style: GoogleFonts.poppins(fontSize: 14,color: Colors.white, fontWeight: FontWeight.bold),)),
                Divider(color: Colors.white, thickness: 1,),
                Center(child: Text("GH¢ ${e.room.price}", style: GoogleFonts.poppins(fontSize: 15,color: Colors.white, fontWeight: FontWeight.bold),))
              ],
            ),
          ),
        )
        ).toList(),
      )
      ],
    ) : Text(""),
                threeInaRoom.isNotEmpty ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        children: [
                          Text("Three in a Room", style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Icon(CustomIcons.three_inna),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.black38,
                    ),

                    Wrap(
                      spacing: 2,
                      children: threeInaRoom.map((e) => InkWell(
                        onTap: (){
                          MyNavigator.navigateTo(context, EditRoomPage(room: e.room));

                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          margin: EdgeInsets.only(left: 6, right: 6,top: 6),
                          // height: 70,
                          width: 110,
                          // color: Colors.red,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(child: Text("${e.room.roomLabel}", style: GoogleFonts.poppins(fontSize: 14,color: Colors.white, fontWeight: FontWeight.bold),)),
                              Divider(color: Colors.white, thickness: 1,),
                              Center(child: Text("GH¢ ${e.room.price}", style: GoogleFonts.poppins(fontSize: 15,color: Colors.white, fontWeight: FontWeight.bold),))
                            ],
                          ),
                        ),
                      )
                      ).toList(),
                    )
                  ],
                ): Text(""),

                fourInaRoom.isNotEmpty ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        children: [
                          Text("Four in a Room", style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Icon(CustomIcons.four_inna, size: 30,),
                          )

                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.black38,
                    ),

                    Wrap(
                      spacing: 2,
                      children: fourInaRoom.map((e) => InkWell(
                        onTap: (){
                          MyNavigator.navigateTo(context, EditRoomPage(room: e.room));

                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          margin: EdgeInsets.only(left: 6, right: 6,top: 6),
                          // height: 70,
                          width: 110,
                          // color: Colors.red,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(child: Text("${e.room.roomLabel}", style: GoogleFonts.poppins(fontSize: 14,color: Colors.white, fontWeight: FontWeight.bold),)),
                              Divider(color: Colors.white, thickness: 1,),
                              Center(child: Text("GH¢ ${e.room.price}", style: GoogleFonts.poppins(fontSize: 15,color: Colors.white, fontWeight: FontWeight.bold),))
                            ],
                          ),
                        ),
                      )
                      ).toList(),
                    )
                  ],
                ) : Text(""),
              ],
            )


          )
        ),
      ),
    );
  }
}
