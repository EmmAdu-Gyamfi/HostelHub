import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub_mobile_app/cubit/edit_room/edit_room_cubit.dart';
import 'package:hostel_hub_mobile_app/utilities/dimensions.dart';
import 'package:hostel_hub_mobile_app/utilities/utils.dart';
import '../cubit/add_hostel_room/add_hostel_room_cubit.dart';
import '../data/hostel.dart';
import '../data/room.dart';
import '../utilities/dialog_helper.dart';
import '../utilities/my_navigator.dart';
import 'add_room_photo_page.dart';
import 'edit_room_photo_page.dart';

class EditRoomPage extends StatefulWidget {
  final Room room;
  const EditRoomPage({Key? key, required this.room}) : super(key: key);

  @override
  State<EditRoomPage> createState() => _EditRoomPageState();
}

class _EditRoomPageState extends State<EditRoomPage> {
   bool _progressDialogShowing = false;
   TextEditingController _roomPriceController = TextEditingController();
   TextEditingController _roomLabelController = TextEditingController();
   String? hostelConditionValue;
  late var room;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    room = widget.room;
    hostelConditionValue = widget.room.roomCategory.toString();
    _roomPriceController = TextEditingController(text: widget.room.price.toString());
    _roomLabelController = TextEditingController(text: widget.room.roomLabel);


  }
  void dispose(){
    _roomLabelController.dispose();
    _roomPriceController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    List<String> roomCategoryList = <String>['One In a Room', 'Two In a Room', 'Three In a Room', 'Four In a Room'];
    bool showFab = true;
    double screenWidth = MediaQuery. of(context). size. width ;
    double screenHeight = MediaQuery. of(context). size. height;

    return BlocListener<EditRoomCubit, EditRoomState>(
      listener: (context, state) {
        if(state is EditRoomSucceeded || state is EditRoomFailed) {
          if(_progressDialogShowing) {
            Navigator.of(context, rootNavigator: true).pop();
            _progressDialogShowing = false;
          }

          if (state is EditRoomSucceeded) {
            // MyNavigator.navigateTo(
            //     context, AddRoomPhotoMobilePage(room: state.room));
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => EditRoomPhotoMobilePage(room: widget.room)));
          } else if (state is EditRoomFailed) {
            DialogHelper.showSimpleSnackBar(context, state.Message);
          }
        } else {
          DialogHelper.showProgressDialog(context, message: "applying changes...");
          _progressDialogShowing = true;
        }
      },
      child: Scaffold(
          floatingActionButton:showFab ? FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            icon: Icon(CupertinoIcons.floppy_disk, size: 22,),
            onPressed: (){
              Room room = Room(
                  roomCategory: hostelConditionValue!,
                  roomLabel: _roomLabelController.text,
                  price: double.tryParse(_roomPriceController.text)!,
              );
              room.roomId = widget.room.roomId;

              BlocProvider.of<EditRoomCubit>(context).putRoom(room);

            },
            label: Text("Save", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),),
            backgroundColor:  primaryColor,
          ) : null,

          body: Container(
              height: double.infinity,
              width: double.infinity,
              color: primaryColor,
              child: Stack(

                  children: [

                    Positioned(
                      top: 35,
                      left: -10,
                      child: RotationTransition(
                          turns: AlwaysStoppedAnimation(50/360),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(30, 46, 61, 1),
                                borderRadius: BorderRadius.circular(30)
                            ),
                          )),
                    ),
                    Positioned(
                      top: -167,
                      right: -35,
                      child: RotationTransition(
                          turns: AlwaysStoppedAnimation(60/360),
                          child: Container(
                            height: 220,
                            width: 220,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(71, 69, 90, 0.3),
                                borderRadius: BorderRadius.circular(30)
                            ),
                          )),
                    ),
                    Positioned(
                      top: screenHeight*0.055,
                      left: screenWidth*0.36,
                      child: Text(
                        "Edit Room",
                        style: GoogleFonts.roboto(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),

                    Positioned(
                        top: screenHeight*0.054,
                        left:16,
                        child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back, color: Colors.white, size: 30,))),

                    Container(
                      margin: EdgeInsets.only(top: screenHeight*0.1),
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(standardMargin),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
                              child: Text("Room Category", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                            ),

                            DropdownButtonFormField(
                              value: hostelConditionValue,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Color.fromRGBO(71, 69, 90, 1)
                                    ),
                                  ),
                                  fillColor: Color.fromRGBO(71, 69, 90, 0.1),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(71, 69, 90, 1)
                                    ),
                                  )
                              ),
                              items: roomCategoryList.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  hostelConditionValue = value;
                                });
                              },),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
                              child: Text("Room Label", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                            ),
                            TextFormField(
                              controller: _roomLabelController,
                              onChanged: (_) => setState(() {

                              }),
                              cursorColor: Color.fromRGBO(71, 69, 90, 1),
                              cursorWidth: 1,
                              decoration: InputDecoration(
                                  errorText: validateRoomLabel(_roomLabelController.text),
                                  // errorBorder: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(10),
                                  //   borderSide: BorderSide(
                                  //       color: Colors.red
                                  //   ),
                                  // ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(71, 69, 90, 1)
                                    ),
                                  ),
                                  fillColor: Color.fromRGBO(71, 69, 90, 0.1),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Color.fromRGBO(71, 69, 90, 1)
                                    ),
                                  ),

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(71, 69, 90, 1)
                                    ),
                                  )
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
                              child: Text("Room Price", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                            ),

                            TextField(
                              cursorColor: Color.fromRGBO(71, 69, 90, 1),
                              cursorWidth: 1,
                              onChanged: (value) => setState(() {

                              }),
                              controller: _roomPriceController,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(" "),
                              ],
                              decoration: InputDecoration(
                                  errorText:validateRoomPrice(_roomPriceController.text),
                                  prefix: Text("GH¢   ", style: GoogleFonts.poppins(),),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(71, 69, 90, 1)
                                    ),
                                  ),
                                  fillColor: Color.fromRGBO(71, 69, 90, 0.1),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Color.fromRGBO(71, 69, 90, 1)
                                    ),
                                  ),

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(71, 69, 90, 1)
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]
              )
          )
      ),
    );
  }
}

String? validateRoomLabel(String value) {
  if(value.isEmpty){
    return "This field is required";
  }
  if(value.length < 5){
    return "Too short";
  }
  if(value.length > 36){
    return "Too long";
  }

  return null;
}

String? validateRoomPrice(String value) {
  if(value.isEmpty){
    return "This field is required";
  }

  if(!(RegExp(r'^[0-9-]+$').hasMatch(value))){
    return "Input is invalid, no punctuations or letters";
  }

  if(value.length >= 15){
    return "Too long";
  }

  if(value.length <= 2){
    return "Too short";
  }


}