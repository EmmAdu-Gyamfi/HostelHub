import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/brandico_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/fontelico_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub_mobile_app/pages/three_in_a_room_page.dart';
import 'package:hostel_hub_mobile_app/pages/two_in_a_room_page.dart';
import 'package:hostel_hub_mobile_app/utilities/custom_icons_icons.dart';
import 'package:hostel_hub_mobile_app/utilities/utils.dart';

import '../data/hostel.dart';

import 'four_in_a_room_page.dart';
import 'one_in_a_room_page.dart';

class ViewRoomMobilePage extends StatefulWidget {
  final List<HostelRooms> rooms;
  final String hostelName;

  const ViewRoomMobilePage({Key? key, required this.rooms, required this.hostelName}) : super(key: key);

  @override
  State<ViewRoomMobilePage> createState() => _ViewRoomMobilePageState();
}

class _ViewRoomMobilePageState extends State<ViewRoomMobilePage> {
  late var rooms;
  late var hostelName;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rooms = widget.rooms;
    hostelName = widget.hostelName;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      OneInARoomMobilePage(rooms: rooms, hostelName: hostelName),
      TwoInARoomMobilePage(rooms: rooms, hostelName: hostelName),
      ThreeInARoomMobilePage(rooms: rooms, hostelName: hostelName),
      FourInARoomMobilePage(rooms: rooms, hostelName: hostelName),

    ];
    double screenWidth = MediaQuery. of(context). size. width ;
    double screenHeight = MediaQuery. of(context). size. height;
    return Scaffold(
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: primaryColor,
        iconSize: 30,
        onTap: (int val) {
          setState(() {
            index = val;
          });
        },
        currentIndex: index,
        items: [
          FloatingNavbarItem(icon: CupertinoIcons.person_fill, title: 'Single'),
          FloatingNavbarItem(icon: CupertinoIcons.person_2_fill, title: 'Dual'),
          FloatingNavbarItem(icon: CustomIcons.three_inna, title: 'Triple'),
          FloatingNavbarItem(icon: CustomIcons.four_inna, title: 'Quad'),
        ],
      ),
          body: tabs[index]
    );
  }
}
