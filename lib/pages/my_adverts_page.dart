import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub_mobile_app/cubit/get_hostel/get_hostels_cubit.dart';
import 'package:like_button/like_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../data/hostel.dart';
import '../utilities/my_navigator.dart';
import '../utilities/utils.dart';
import 'hostel_details_page.dart';
import 'main_edit_file.dart';

class MyAdvertsPage extends StatefulWidget {
 // final Hostel hostel;
  const MyAdvertsPage({super.key});

  @override
  State<MyAdvertsPage> createState() => _MyAdvertsPageState();
}

class _MyAdvertsPageState extends State<MyAdvertsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserHostels();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: BlocBuilder<GetHostelsCubit, HostelsState>(
    builder: (context, state){
    if(state is HostelsLoadingSucceeded){
   var hostels = state.hostels;
    if(hostels.length == 0){
    return Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Stack(
    alignment: Alignment.center,
    children: [
    Image.asset("assets/emptyList.png", height: 300, width: 300),
    Positioned(
    bottom: 50,
    child: Text("No Adverts Found!",
    style: GoogleFonts.robotoSlab(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 22),
    ),
    ),
    Positioned(
    bottom: 30,
    child: Text("Sorry, we couldn't find any adverts!",
    style: GoogleFonts.robotoSlab(color: primaryColor, fontWeight: FontWeight.normal, fontSize: 16),
    ),
    ),
    ],
    ),

    ],
    ),
    );
    }
    return Padding(
    padding: const EdgeInsets.only(top:8.0,),
    child: ListView.builder(
    itemCount: hostels.length,
    // itemBuilder: (context, index){
    //  return Text("sd");
    // },
    itemBuilder: (context, index){
    return InkWell(
    onTap: (){
     Navigator.push(context, MaterialPageRoute(builder: (context) => MainEditPage(hostel: hostels[index],)));
    },
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    Stack(
    children:[
    Padding(
    padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10),
    child: InkWell(
    child: AspectRatio(
    aspectRatio: 16/9,
    child: Container(
    height: 150,
    width: double.infinity,
    decoration: BoxDecoration(
    // color: Colors.redAccent,

    ),
    child: ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: CachedNetworkImage(
    fadeInDuration: Duration(microseconds: 300),
    fit: BoxFit.fill,
    imageUrl: "$baseUrl/FileStore/${hostels[index].hostelPhotos[0].fileId}",
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
    onTap: (){
     Navigator.push(context, MaterialPageRoute(builder: (context) => MainEditPage(hostel:hostels[index])));
    },
    ),
    ),
    Positioned(

    child: InkWell(
    child: Chip(label: Text("${hostels[index].locality}", style: GoogleFonts.robotoCondensed(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),backgroundColor: Color.fromRGBO(71, 69, 90, 0.1),
    ),
    onTap: (){
     Navigator.push(context, MaterialPageRoute(builder: (context) => MainEditPage(hostel: hostels[index],)));
    },
    ),
    bottom: 25,
    right: 28,
    )
    ],
    ),
    Padding(
    padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 20.0),
    child: Row(
    children: [
    Column(
    children: [
    Padding(
    padding: const EdgeInsets.only(bottom: 0.0),
    child: InkWell(child: Text("${hostels[index].name}", style: GoogleFonts.merriweather(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20))
    ,
    onTap: (){
     Navigator.push(context, MaterialPageRoute(builder: (context) => MainEditPage(hostel: hostels[index],)));
    },
    ),
    ),
    Container(child: InkWell(child: Chip(label: Row(
    children: [
    Text("GH¢ ${hostels[index].minimumPriceRange}-", style: GoogleFonts.roboto(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
    Text("${hostels[index].maximumPriceRange}", style: GoogleFonts.roboto(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
    ],
    ), backgroundColor: Colors.green,),
    onTap: (){
     Navigator.push(context, MaterialPageRoute(builder: (context) => MainEditPage(hostel: hostels[index],)));
    },
    )
    ),
    ],
    crossAxisAlignment: CrossAxisAlignment.start,
    ),

    ],

    crossAxisAlignment: CrossAxisAlignment.start,
    ),
    ),

    ],
    ),
    );
    }
    ),
    );
    } return Text(""); }
    )
    );
  }

  void _loadUserHostels() {
    BlocProvider.of<GetHostelsCubit>(context).loadUserHostels();
  }
}
