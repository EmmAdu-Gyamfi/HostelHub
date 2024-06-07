import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub_mobile_app/cubit/get_hostel/get_hostels_cubit.dart';
import 'package:hostel_hub_mobile_app/pages/add_hostel_page.dart';
import 'package:hostel_hub_mobile_app/pages/add_hostel_photo_page.dart';
import 'package:hostel_hub_mobile_app/pages/add_hostel_room_page.dart';
import 'package:hostel_hub_mobile_app/pages/hostel_details_page.dart';
import 'package:hostel_hub_mobile_app/pages/my_adverts_page.dart';
import 'package:hostel_hub_mobile_app/pages/welcome_page.dart';
import 'package:hostel_hub_mobile_app/utilities/my_navigator.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/search_hostel/search_hostel_cubit.dart';
import '../data/hostel.dart';
import '../data/room.dart';
import '../utilities/dialog_helper.dart';
import '../utilities/utils.dart';
import 'add_room_photo_page.dart';
import 'filter_page.dart';
import 'login_page.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({Key? key}) : super(key: key);

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  bool showFab = true;
  var searchString = "";
  bool _progressDialogShowing = false;
  bool isFavourite = false;
  var searchBarController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchHostels();
    _scrollController = ScrollController();

  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late List<Hostel> hostels;
    double screenWidth = MediaQuery. of(context). size. width ;
    double screenHeight = MediaQuery. of(context). size. height;
    return BlocListener<SearchHostelCubit, SearchHostelState>(
  listener: (context, state) {
    if(state is SearchHostelLoadingSucceeded ||
        state is SearchHostelLoadingFailed ||
        state is SearchHostelCompleted ||
        state is FilteredHostelResultsLoadingSucceeded ||
        state is FilteredHostelResultsLoadingFailed
    ) {
      if(_progressDialogShowing) {
        Navigator.of(context, rootNavigator: true).pop();
        _progressDialogShowing = false;
      }

      if (state is SearchHostelCompleted) {

        DialogHelper.showSimpleSnackBar(context, "Search completed");

      } else if(state is FilteredHostelResultsLoadingSucceeded){
        DialogHelper.showSimpleSnackBar(context, "Filtering completed");
      }
      else if (state is SearchHostelLoadingFailed) {
        DialogHelper.showSimpleSnackBar(context, state.message.toString());
      }
      else if(state is FilteredHostelResultsLoadingFailed){
        DialogHelper.showSimpleSnackBar(context, state.message.toString());
      }
    } else if(state is FilteredHostelResultsLoadingInProgress){
      DialogHelper.showProgressDialog(context, message: "Filtering hostels...");
      _progressDialogShowing = true;
    }else if (state is SearchHostelLoadingInProgress){
      DialogHelper.showProgressDialog(context, message: "Searching for hostels...");
      _progressDialogShowing = true;
    }
    else {
      DialogHelper.showProgressDialog(context, message: "Searching for hostels...");
      _progressDialogShowing = true;
    }
  },
  child: Scaffold(
      floatingActionButton:showFab ? FloatingActionButton.extended(
        onPressed: (){
          // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);

           Navigator.push(context, MaterialPageRoute(builder: (context) => AddHostelMobilePage()));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        icon: Icon(Icons.add, size: 30, color: Colors.white,),
        backgroundColor:  primaryColor, label: Text("Add Hostel", style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white), ),
      ) : null,


      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.only(left:8.0, right: 8.0, bottom: 8.0),
            child: Container(
              height: 40,
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
                controller: searchBarController,
                onSubmitted: (value){
                  setState(() {
                    searchString = value;
                  });
                   _searchHostels();

                },
                cursorColor: Colors.white,
                cursorHeight: 25,

              decoration: InputDecoration(
                hintText: " Search for a hostel...",
                hintStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                prefixIcon: Icon(Icons.search, color: Colors.white, size: 26,),
                suffixIcon: InkWell(
                    onTap: (){
                        MyNavigator.navigateTo(context, FilterMobilePage());
                    },
                    child: Icon(Icons.tune_rounded, color: Colors.white, size: 26,)),
                contentPadding: EdgeInsets.only(bottom:0, left: 16),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                disabledBorder:  OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder:  OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white
                  ),
                  borderRadius: BorderRadius.circular(20),
                )
              ),
              ),
            ),
          ),
        ),
        backgroundColor: primaryColor,

        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 8.0),

            child: InkWell(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        elevation: 60,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        title:  Text('Already leaving?', style: GoogleFonts.poppins(fontSize: 20),),
                        content:  Text('We will keep an eye out for more eye catching hostels.', style: GoogleFonts.poppins(fontSize: 16)),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: Text('No, I\'m staying', style: GoogleFonts.poppins(color: Colors.black),),
                          ),
                          TextButton(
                            onPressed: () async{
                              await FirebaseAuth.instance.signOut();
                              Navigator.pop(context);
                              // SharedPreferences prefs = await SharedPreferences.getInstance();
                              // prefs.remove('token');
                              // Navigator.pushReplacement(context,
                              //     MaterialPageRoute(builder: (BuildContext ctx) => LoginMobilePage()));
                            },
                            child: Container(
                                child:  Text('Yes, Log out', style: GoogleFonts.poppins(color: Colors.white),),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              padding: EdgeInsets.all(8),
                            )
                          ),
                        ],
                      );
                    }
                  );

                },
                child: Icon(Icons.account_circle, size: 27,color: Colors.white,)
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: PopupMenuButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)

              ),
              icon: Icon(Icons.list, size: 34,color: Colors.white,),
              itemBuilder: ( context) {
                return <PopupMenuEntry>[
                  PopupMenuItem(
                      child: Container(

                        // height: 100,
                        // width: 100,
                        // color: Colors.grey,
                        child: Column(
                          children:<Widget>[
                            Text("Favourites", style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 17,),),
                            Divider(thickness: 1),
                            InkWell(
                              onTap: (){
                                MyNavigator.navigateTo(context, MyAdvertsPage());
                              },
                                child: Container(child: Text("My adverts", style: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 17,),)),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      )
                  )

                ];
              },),


          ),


        ],
        title: Text("Hostel hub", style: GoogleFonts.merriweather(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27,),),

      ),

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
        child: BlocBuilder<SearchHostelCubit, SearchHostelState>(
          builder: (context, state){
            if(state is SearchHostelLoadingSucceeded){
               hostels = state.hostels;
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
                             child: Text("No Hostels Found!",
                               style: GoogleFonts.robotoSlab(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 22),
                             ),
                           ),
                           Positioned(
                             bottom: 30,
                             child: Text("Sorry, we couldn't find any hostels!",
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
                child: RefreshIndicator(
                  onRefresh:() async {
                    await BlocProvider.of<SearchHostelCubit>(context).searchHostels(searchString);
                  },
                  child: ListView.builder(
                    itemCount: hostels.length,
                      itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){
                        MyNavigator.navigateTo(context, HostelDetailsMobilePage(hostel: hostels[index]));
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
                                  },
                                ),
                              ),
                              Positioned(

                                child: InkWell(
                                  child: Chip(label: Text("${hostels[index].locality}", style: GoogleFonts.robotoCondensed(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),backgroundColor: Color.fromRGBO(71, 69, 90, 0.1),
                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
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
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
                                      },
                                    )
                                    ),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),

                                Spacer(),

                                LikeButton(
                                  isLiked: hostels[index].isLiked,

                                //   onTap: (value) async{
                                //     hostels[index].isLiked = value;
                                // },
                                  size: 30,
                                )
                                // InkWell(
                                //   onTap: (){
                                //     setState(() {
                                //       hostels[index].isLiked = !hostels[index].isLiked;
                                //     });
                                //   },
                                //   child: Container(
                                //       height: 40,
                                //       width: 40,
                                //       // color: Colors.pink,
                                //       child: hostels[index].isLiked ? Icon(Icons.favorite_border, size: 28,) : Icon(Icons.favorite, color: Colors.red, size: 28,)),
                                // )

                                // Padding(
                                //   padding: const EdgeInsets.only(top:2.2
                                //   ),
                                //   child: InkWell(child: Icon(Icons.star_rate_rounded, color: Colors.orange, size: 14,),
                                //     onTap: (){
                                //       Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
                                //     },
                                //   ),
                                // ),

                                // InkWell(child: Text("7.1", style: GoogleFonts.poppins(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 14)),
                                //   onTap: (){
                                //     Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
                                //   },
                                // ),
                              ],

                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),

                        ],
                      ),
                    );
                  }),
                ),
              );
            } else if(state is SearchHostelCompleted){
              hostels = state.hostels;
              if(hostels.isEmpty){
                return Center(
                  child: Container(
                    // color: Colors.amberAccent,
                    height: screenHeight,
                    child: AspectRatio(
                      aspectRatio: 16/9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                             alignment: Alignment.center,
                            children: [
                              Image.asset("assets/emptyList.png", height: 300, width: 300,),
                              Positioned(
                                bottom: 40,
                                child: Text("No Hostels Found!",
                                  style: GoogleFonts.robotoSlab(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Text("Sorry, we couldn't find any hostels!",
                                  style: GoogleFonts.robotoSlab(color: primaryColor, fontWeight: FontWeight.normal, fontSize: 12),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top:8.0,),
                child: ListView.builder(
                    itemCount: hostels.length,
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          MyNavigator.navigateTo(context, HostelDetailsMobilePage(hostel: hostels[index]));
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
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
                                    },
                                  ),
                                ),
                                Positioned(

                                  child: InkWell(
                                    child: Chip(label: Text("${hostels[index].locality}", style: GoogleFonts.robotoCondensed(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),backgroundColor: Color.fromRGBO(71, 69, 90, 0.1),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
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
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
                                          },
                                        ),
                                      ),
                                      Container(child: InkWell(child: Chip(label: Row(
                                        children: [
                                          Text("GH¢ ${hostels[index].minimumPriceRange}-", style: GoogleFonts.robotoCondensed(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                          Text("${hostels[index].maximumPriceRange}", style: GoogleFonts.robotoCondensed(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),

                                        ],
                                      ), backgroundColor: Colors.green,),

                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
                                        },
                                      )
                                      ),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),

                                  Spacer(),

                                  // Padding(
                                  //   padding: const EdgeInsets.only(top:2.2
                                  //   ),
                                  //   child: InkWell(child: Icon(Icons.star_rate_rounded, color: Colors.orange, size: 14,),
                                  //     onTap: (){
                                  //       Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
                                  //     },
                                  //   ),
                                  // ),

                                  // InkWell(child: Text("7.1", style: GoogleFonts.poppins(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 14)),
                                  //   onTap: (){
                                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
                                  //   },
                                  // ),
                                ],

                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),

                          ],
                        ),
                      );
                    }),
              );
            } else if(state is FilteredHostelResultsLoadingSucceeded){
              hostels = state.hostels;
              if(hostels.isEmpty){
                return Padding(
                  padding: const EdgeInsets.only(bottom:100.0, left: 0),
                  child: Container(
                    // color: Colors.amberAccent,
                    height: screenHeight,
                    child: AspectRatio(
                      aspectRatio: 16/9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset("assets/emptyList.png", height: 300, width: 300,),
                              Positioned(
                                bottom: 40,
                                child: Text("No Hostels Found!",
                                  style: GoogleFonts.robotoSlab(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Text(" Looks like we couldn't find what you were looking for!",
                                  style: GoogleFonts.robotoSlab(color: primaryColor, fontWeight: FontWeight.normal, fontSize: 12),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top:8.0,),
                child: ListView.builder(
                    itemCount: hostels.length,
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          MyNavigator.navigateTo(context, HostelDetailsMobilePage(hostel: hostels[index]));
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
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
                                    },
                                  ),
                                ),
                                Positioned(

                                  child: InkWell(
                                    child: Chip(label: Text("${hostels[index].locality}", style: GoogleFonts.robotoCondensed(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),backgroundColor: Color.fromRGBO(71, 69, 90, 0.1),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
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
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
                                          },
                                        ),
                                      ),
                                      Container(child: InkWell(child: Chip(label: Row(
                                        children: [
                                          Text("GH¢ ${hostels[index].minimumPriceRange}-", style: GoogleFonts.robotoCondensed(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                          Text("${hostels[index].maximumPriceRange}", style: GoogleFonts.robotoCondensed(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),

                                        ],
                                      ), backgroundColor: Colors.green,),

                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
                                        },
                                      )
                                      ),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),

                                  Spacer(),

                                  // Padding(
                                  //   padding: const EdgeInsets.only(top:2.2
                                  //   ),
                                  //   child: InkWell(child: Icon(Icons.star_rate_rounded, color: Colors.orange, size: 14,),
                                  //     onTap: (){
                                  //       Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
                                  //     },
                                  //   ),
                                  // ),

                                  // InkWell(child: Text("7.1", style: GoogleFonts.poppins(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 14)),
                                  //   onTap: (){
                                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => HostelDetailsMobilePage(hostel: hostels[index])));
                                  //   },
                                  // ),
                                ],

                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),

                          ],
                        ),
                      );
                    }),
              );
            }else if(state is FilteredHostelResultsLoadingFailed){
              var message = state.message;
              return Center(child: Text(message.toString()));
            }
            else if(state is SearchHostelLoadingFailed){
              var message = state.message;
              return Center(child: Text(message.toString()));
            }
            return Text("");
          },
        ),
      ),
    ),
);
  }

  // void _loadHostels() {
  //   BlocProvider.of<GetHostelsCubit>(context).loadHostels();
  // }

  void _searchHostels() {
    BlocProvider.of<SearchHostelCubit>(context).searchHostels(searchString);
  }




  // String getCurrency() {
  //   var format = NumberFormat.simpleCurrency(locale: 'en_GH');
  //   return format.currencySymbol;
  // }
}
