// import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub_mobile_app/cubit/edit_hostel/edit_hostel_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/hostel.dart';
import '../utilities/dialog_helper.dart';
import '../utilities/utils.dart';
import 'homepage.dart';

class EditHostelInfo extends StatefulWidget {
  final Hostel hostel;

   EditHostelInfo({super.key, required this.hostel});
  var userId;


  @override
  State<EditHostelInfo> createState() => _EditHostelInfoState();
}

class _EditHostelInfoState extends State<EditHostelInfo> {
  bool showFab = true;
  ScrollController _scrollController = ScrollController();
  late String? hostelConditionValue;
  late String? hostelFurnishingValue;
  late String? wifiValue;
  late String? laundryServices;
  late String? studyRoom;
  late String? security;

  late bool _switchValue;
  bool _progressDialogShowing = false;
  String? regionValue;
  String? cityValue = "";
  String countryValue = "";
   TextEditingController _hostelNameController = TextEditingController();
   TextEditingController _hostelLocalityController = TextEditingController();
   TextEditingController _digitalAddressController = TextEditingController();
   TextEditingController _minimumRentTimeController = TextEditingController();
   TextEditingController _phoneNumberController = TextEditingController();
   TextEditingController _alternativePhoneNumberController = TextEditingController();
   TextEditingController _minimumPriceRangeController = TextEditingController();
   TextEditingController _maximumPriceRangeController = TextEditingController();
   TextEditingController _hostelDescriptionController = TextEditingController();

   var hostelId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserId();
    hostelId = widget.hostel.hostelId;
    _scrollController = ScrollController();
    _hostelNameController = TextEditingController(text: widget.hostel.name);
    hostelConditionValue = "${widget.hostel.condition}";
    wifiValue = "${widget.hostel.wiFi}";
    laundryServices = "${widget.hostel.laundryServices}";
    studyRoom = "${widget.hostel.studyRoom}";
    security = "${widget.hostel.security}";
    hostelFurnishingValue = "${widget.hostel.furnishing}";
    _minimumRentTimeController = TextEditingController(text: widget.hostel.minimumRentTime.toString());
    _minimumPriceRangeController = TextEditingController(text: widget.hostel.minimumPriceRange.toString());
    _maximumPriceRangeController = TextEditingController(text: widget.hostel.maximumPriceRange.toString());
    _hostelDescriptionController = TextEditingController(text: widget.hostel.description);
    _digitalAddressController = TextEditingController(text: widget.hostel.address);
    _hostelLocalityController = TextEditingController(text: widget.hostel.locality);
    _phoneNumberController = TextEditingController(text: widget.hostel.phoneNumber);
    _alternativePhoneNumberController = TextEditingController(text: widget.hostel.alternativePhoneNumber);
    _switchValue = widget.hostel.negotiation;
    // _loadUserId();


  }

  @override
  void dispose(){
    _scrollController.dispose();
    _hostelNameController.dispose();
    _hostelLocalityController.dispose();
    _digitalAddressController.dispose();
    _minimumRentTimeController.dispose();
    _phoneNumberController.dispose();
    _hostelDescriptionController.dispose();
    _minimumPriceRangeController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    List<String> wifiList = <String>['Yes(Free)', 'Yes(Subscription)', 'No'];
    List<String> laundryServicesList = <String>['Available', 'Unavailable'];
    List<String> studyRoomList = <String>['Available', 'Unavailable'];
    List<String> securityList = <String>['Available', 'Unavailable'];
    List<String> conditionList = <String>['Fairly-Used Building', 'Newly-Built', 'Old Building', 'Renovated Building'];
    List<String> furnishingList = <String>['Fully-Furnished', 'Semi-Furnished', 'Unfurnished'];
    double screenWidth = MediaQuery. of(context). size. width ;
    double screenHeight = MediaQuery. of(context). size. height;
    return BlocListener<EditHostelCubit, EditHostelState>(
      listener: (context, state) {
        if(state is EditHostelSucceeded || state is EditHostelFailed) {
          if(_progressDialogShowing) {
            Navigator.of(context, rootNavigator: true).pop();
            _progressDialogShowing = false;
          }

          if (state is EditHostelSucceeded) {

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => MobileHomePage()));

            DialogHelper.showSimpleSnackBar(context, "Changes saved successfully");

          }
          else if (state is EditHostelFailed) {
            DialogHelper.showSimpleSnackBar(context, "Oops, something went wrong");
          }

        }
        else {
          DialogHelper.showProgressDialog(context, message: "Processing");
          _progressDialogShowing = true;
        }
      },
  child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: NotificationListener<UserScrollNotification>(
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
        child: Scaffold(
          floatingActionButton:showFab ? FloatingActionButton.extended(
            elevation: 20,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            icon: Icon(CupertinoIcons.floppy_disk, size: 22,),
            onPressed: (){

              Hostel hostel = Hostel(
                  address: _digitalAddressController.text,
                  condition: hostelConditionValue!,
                  description: _hostelDescriptionController.text,
                  furnishing: hostelFurnishingValue!,
                  locality: _hostelLocalityController.text,
                  name: _hostelNameController.text,
                  minimumRentTime: int.parse(_minimumRentTimeController.text),
                  negotiation: _switchValue,
                  minimumPriceRange: int.tryParse(_minimumPriceRangeController.text),
                  phoneNumber: _phoneNumberController.text,
                  // city: cityValue.toString(),
                  // region: regionValue.toString(),
                  alternativePhoneNumber: _alternativePhoneNumberController.text,
                  maximumPriceRange:  int.tryParse(_maximumPriceRangeController.text),
                  laundryServices: laundryServices!,
                  security: security!,
                  studyRoom: studyRoom!,
                  wiFi: wifiValue!,
                  // addedBy: widget.userId
              );
              hostel.hostelId = hostelId;
              hostel.city = widget.hostel.city;
              hostel.region = widget.hostel.region;
              hostel.addedBy = widget.userId;

              BlocProvider.of<EditHostelCubit>(context).putHostel(hostel);

            },
            label: Text("Save", style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),),
            backgroundColor:  primaryColor,
          ) : null,
          // backgroundColor: Colors.amber,
          body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(CupertinoIcons.info_circle, color: Colors.black, size: 22,),
                      SizedBox(width: 5,),
                      Text("Hostel Information", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Divider(
                      height: 1,
                      thickness: 1.5,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
                    child: Text("Hostel Name", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                  ),
                  TextFormField(
                    controller: _hostelNameController,
                    onChanged: (_) => setState(() {

                    }),
                    cursorColor: Colors.black,
                    cursorWidth: 1,
                    decoration: InputDecoration(
                        errorText: validateHostelName(_hostelNameController.text),
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
                    child: Text("Hostel Condition", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
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
                    items: conditionList.map<DropdownMenuItem<String>>((String value) {
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
                    child: Text("WiFi", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                  ),

                  DropdownButtonFormField(
                    value: wifiValue,
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
                    items: wifiList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        wifiValue = value;
                      });
                    },),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
                    child: Text("Laundry Services", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                  ),

                  DropdownButtonFormField(
                    value: laundryServices,
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
                    items: laundryServicesList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        laundryServices = value;
                      });
                    },),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
                    child: Text("Study Room", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                  ),

                  DropdownButtonFormField(
                    value: studyRoom,
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
                    items: studyRoomList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        studyRoom = value;
                      });
                    },),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
                    child: Text("Security", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                  ),

                  DropdownButtonFormField(
                    value: security,
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
                    items: securityList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        security = value;
                      });
                    },),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
                    child: Text("Hostel Furnishing", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                  ),

                  DropdownButtonFormField(
                    value: hostelFurnishingValue,
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
                    items: furnishingList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        hostelFurnishingValue = value;
                      });
                    },),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
                    child: Text("Minimum Rent Time", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                  ),

                  TextField(
                    cursorColor: Color.fromRGBO(71, 69, 90, 1),
                    cursorWidth: 1,
                    onChanged: (value) => setState(() {

                    }),
                    controller: _minimumRentTimeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        errorText: validateMinimumRentTime(_minimumRentTimeController.text),
                        suffix: Text("Year(s)", style: GoogleFonts.poppins(),),
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
                    child: Text("Minimum Price Range", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                  ),

                  TextField(
                    cursorColor: Color.fromRGBO(71, 69, 90, 1),
                    cursorWidth: 1,
                    onChanged: (value) => setState(() {

                    }),
                    controller: _minimumPriceRangeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        errorText:validatepriceRange(_minimumPriceRangeController.text),
                        prefix: Text("GH¢   ", style: GoogleFonts.poppins(),),
                        // hintText: "e.g, 1000-8000",
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
                    child: Text("Maximum Price Range", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                  ),

                  TextField(
                    cursorColor: Color.fromRGBO(71, 69, 90, 1),
                    cursorWidth: 1,
                    onChanged: (value) => setState(() {

                    }),
                    controller: _maximumPriceRangeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        // errorText:validatepriceRange(_minimumPriceRangeController.text),
                        prefix: Text("GH¢   ", style: GoogleFonts.poppins(),),
                        // hintText: "e.g, 1000-8000",
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
                    padding: const EdgeInsets.only(top:16, left: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Negotiable",style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                        Spacer(),
                        CupertinoSwitch(
                          value: _switchValue,
                          onChanged: (value) {
                            setState(() {
                              _switchValue = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
                    child: Text("Hostel Description", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                  ),
                  TextField(
                    onChanged: (value) => setState(() {

                    }),
                    controller: _hostelDescriptionController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    cursorColor: Color.fromRGBO(71, 69, 90, 1),
                    cursorWidth: 1,
                    decoration: InputDecoration(
                        counterText: "${_hostelDescriptionController.text.length}/500",
                        errorText:validateHostelDescription(_hostelDescriptionController.text),
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
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(CupertinoIcons.map_pin_ellipse, color: Colors.black, size: 22,),
                        SizedBox(width: 5,),
                        Text("Hostel Address", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Divider(
                      height: 1,
                      thickness: 1.5,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
                    child: Text("Digital Address", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                  ),

                  TextField(
                    onChanged: (value) => setState(() {

                    }),
                    cursorColor: Color.fromRGBO(71, 69, 90, 1),
                    cursorWidth: 1,
                    controller: _digitalAddressController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(" ")
                    ],
                    decoration: InputDecoration(
                        // errorText: validateDigitalAddress(_digitalAddressController.text),
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

                  // Padding(
                  //   padding: const EdgeInsets.only(top:16.0),
                  //   child: CSCPicker(
                  //     currentState: regionValue,
                  //     currentCity: cityValue,
                  //     stateDropdownLabel: "Region",
                  //     stateSearchPlaceholder: "Search Region",
                  //     flagState: CountryFlag.ENABLE,
                  //     defaultCountry: CscCountry.Ghana,
                  //     onCountryChanged: (value) {
                  //       setState(() {
                  //         countryValue = value;
                  //       });
                  //     },
                  //     onStateChanged:(value) {
                  //       setState(() {
                  //         regionValue = value;
                  //       });
                  //     },
                  //     onCityChanged:(value) {
                  //       setState(() {
                  //         cityValue = value;
                  //       });
                  //     },
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
                    child: Text("Town", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                  ),

                  TextField(
                    onChanged: (value) => setState(() {

                    }),
                    cursorColor: Color.fromRGBO(71, 69, 90, 1),
                    cursorWidth: 1,
                    controller: _hostelLocalityController,
                    decoration: InputDecoration(
                        errorText: validateHostelLocality(_hostelLocalityController.text),

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
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.phone_in_talk, color: Colors.black, size: 22,),
                        SizedBox(width: 5,),
                        Text("Phone", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:8.0, bottom: 8),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 8),
                    child: Text("Phone Number", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                  ),

                  TextField(
                    cursorColor: Color.fromRGBO(71, 69, 90, 1),
                    cursorWidth: 1,
                    onChanged: (value) => setState(() {

                    }),
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                        errorText:validatephoneNumber(_phoneNumberController.text),
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
                    padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 8),
                    child: Text("Alternate Phone Number", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),),
                  ),

                  TextField(
                    cursorColor: Color.fromRGBO(71, 69, 90, 1),
                    cursorWidth: 1,
                    onChanged: (value) => setState(() {

                    }),
                    controller: _alternativePhoneNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                        errorText:validatephoneNumber(_alternativePhoneNumberController.text),
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



                ]
            ),
          ),
        ),
      ),
    ),
);
  }
  Future<void> _loadUserId() async{
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.userId = int.parse(prefs.getString('userId').toString());
    // widget.userName = prefs.getString('userName').toString();

  }
}

String? validateHostelName(String value) {
  if(value.isEmpty){
    return "This field is required";
  }
  if(value.length < 2){
    return "Too short";
  }
  if(value.length > 100){
    return "Too long";
  }

  return null;
}

String? validatephoneNumber(String value) {
  if(value.isEmpty){
    return "This field is required";
  }
  if(value.length < 10){
    return "Too short";
  }

}

String? validateHostelDescription(String value) {
  if(value.isEmpty){
    return "This field is required";
  }

  if(value.length >= 500){
    return "Too long";
  }

  if(value.length <= 30){
    return "Too short";
  }
}

String? validatepriceRange(String value) {
  if(value.isEmpty){
    return "This field is required";
  }

  if(!(RegExp(r'^[0-9-]+$').hasMatch(value))){
    return "Input is invalid";
  }

  if(value.length >= 15){
    return "Too long";
  }
}

String? validateMinimumRentTime(String value) {
  if(value.isEmpty){
    return "This field is required";
  }
  if(value.length >= 3){
    return "Too long";
  }

  return null;
}

String? validateHostelLocality(String value) {
  if(value.isEmpty){
    return "This field is required";
  }
  if(value.length > 50){
    return "Too long";
  }

  return null;
}

String? validateDigitalAddress(String value) {
  if(value.isEmpty){
    return "This field is required";
  }
  if(value.length < 9){
    return "Too short";
  }
  if(value.length > 12){
    return "Too long";
  }

  return null;
}
