import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub_mobile_app/pages/edit_hostel_photos.dart';

import '../data/hostel.dart';
import '../utilities/utils.dart';
import 'edit_hostel_info_page.dart';
import 'edit_hostel_rooms_page.dart';
import 'hostel_stats_page.dart';




class MainEditPage extends StatefulWidget {
  final Hostel hostel;

  const MainEditPage({super.key, required this.hostel});

  @override
  State<MainEditPage> createState() => _MainEditPageState();
}

class _MainEditPageState extends State<MainEditPage> {

  /// List of Tab Bar Item
  List<String> items = [
    "Hostel Info",
    "Hostel Photos",
    "Rooms",
    "Statistics",
    // "Post",
    // "Activity",
    // "Setting",
    // "Profile",
  ];



  int current = 0;
  var hostel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hostel = widget.hostel;


  }



  /////////////////////////////////////
  //@CodeWithFlexz on Instagram
  //
  //AmirBayat0 on Github
  //Programming with Flexz on Youtube
  /////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    /// List of body icon
    List<Widget> pages = [
      EditHostelInfo(hostel: hostel ),
      EditHostelPhotos(hostel: hostel),
      EditHostelRoomPage(hostel: hostel),
      HostelStatsPage(hostel: hostel),

      // Icons.explore,
      // Icons.search,
      // Icons.feed,
      // Icons.post_add,
      // Icons.local_activity,
      // Icons.settings,
      // Icons.person
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      /// APPBAR
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text("My Adverts", style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold),),
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            /// CUSTOM TABBAR
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              current = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            margin: const EdgeInsets.all(5),
                            width: 100,
                            height: 45,
                            decoration: BoxDecoration(
                              color: current == index
                                  ? primaryColor
                                  : Colors.white54,
                              borderRadius: current == index
                                  ? BorderRadius.circular(15)
                                  : BorderRadius.circular(10),
                              border: current == index
                                  ? Border.all(
                                  color: primaryColor, width: 2)
                                  : Border.all(
                                  color: primaryColor, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                items[index],
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    color: current == index
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: current == index,
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(13, 28, 82, 1),
                                  shape: BoxShape.circle),
                            ))
                      ],
                    );
                  }),
            ),

            /// MAIN BODY
            Expanded(
              child: Container(
                color: Colors.white,
                 margin: const EdgeInsets.only(top: 20),
                // width: double.infinity,
                // height: 550,
                child: pages[current]
              ),
            ),
          ],
        ),
      ),
    );
  }
}