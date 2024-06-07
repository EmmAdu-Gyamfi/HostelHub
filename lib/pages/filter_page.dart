import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/filter_params/filter_params_cubit.dart';
import '../cubit/search_hostel/search_hostel_cubit.dart';
import '../utilities/utils.dart';

class FilterMobilePage extends StatefulWidget {
  const FilterMobilePage({Key? key}) : super(key: key);

  @override
  State<FilterMobilePage> createState() => _FilterMobilePageState();
}

class _FilterMobilePageState extends State<FilterMobilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _loadFilterParams();
  }

  final TextEditingController _minimumPriceController = TextEditingController();
  final TextEditingController _maximumPriceController = TextEditingController();


  String? RegionValue = " ";
  String? CityValue = " ";
  String? TownValue = "Any";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery. of(context). size. width ;
    double screenHeight = MediaQuery. of(context). size. height;


    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(
          color: primaryColor,

          // gradient: LinearGradient(
            //     colors: [
            //       Color.fromRGBO(142, 138, 181, 1),
            //       Color.fromRGBO(142, 138, 181, 1),
            //       Colors.white
            //     ],
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter
            // )
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
              top: screenHeight*0.038,
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
              top: screenHeight*0.054,
              left: screenWidth*0.32,
              child: Text("Filter Results", style: GoogleFonts.roboto(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
            ),


            Positioned(
              top: screenHeight*0.1,
              child: Container(
                height: screenHeight,
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
                      CSCPicker(
                        stateDropdownLabel: "Region",
                        stateSearchPlaceholder: "Search Region",
                        flagState: CountryFlag.ENABLE,
                        defaultCountry: CscCountry.Ghana,
                        disableCountry: true,
                        onCountryChanged: (value) {
                          // setState(() {
                          //   countryValue = value;
                          // });
                        },
                        onStateChanged:(value) {
                          setState(() {
                            RegionValue = value;
                          });
                        },
                        onCityChanged:(value) {
                          setState(() {
                            CityValue = value;
                          });
                        },
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("Price", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16),),
                      ),

                      SizedBox(
                        height: 8,
                      ),

                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: screenWidth*0.4,
                              child: TextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(5),
                                ],
                                controller: _minimumPriceController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    enabled: true,
                                    prefix: Padding(
                                      padding: const EdgeInsets.only(right: 6.0),
                                      child: Text("¢"),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(71, 69, 90, 1)
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(71, 69, 90, 1)
                                      ),
                                    ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(71, 69, 90, 1)
                                    ),
                                  ),

                                  label: Text("Min", style: GoogleFonts.roboto(fontSize: 16, color: Colors.black),)
                                ),

                              ),
                            ),
                          ),

                          Spacer(),

                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              width: screenWidth*0.4,
                              child: TextField(
                                controller: _maximumPriceController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(5),

                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabled: true,

                                    prefix: Padding(
                                      padding: const EdgeInsets.only(right: 6.0),
                                      child: Text("¢"),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(71, 69, 90, 1)
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(71, 69, 90, 1)
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(71, 69, 90, 1)
                                    ),
                                  ),
                                    label: Text("Max", style: GoogleFonts.roboto(fontSize: 16, color: Colors.black),)

                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                      Spacer(),

                      ElevatedButton(
                        onPressed: (){
                          BlocProvider.of<SearchHostelCubit>(context).filterHostels(RegionValue, CityValue, int.tryParse(_maximumPriceController.text), int.tryParse(_minimumPriceController.text));
                          Navigator.pop(context);
                          },
                        child: Text("Filter Results", style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color.fromRGBO(12, 232, 98, 1),),
                            fixedSize: MaterialStateProperty.all(Size(screenWidth, 70)),


                        ),),

                      SizedBox(height: 100,)
                    ],
                  ),




                  // child: BlocBuilder<FilterParamsCubit, FilterParamsState>(
                  //   builder: (context, state){
                  //     if(state is LoadingFilterParamsSucceeded){
                  //       var filterParams = state.filterParams;
                  //       var regions = filterParams.regions;
                  //       var cities = filterParams.citys;
                  //       var towns = filterParams.towns;
                  //       regions.insert(0, "Any");
                  //       cities.insert(0, "Any");
                  //       towns.insert(0, "Any");
                  //
                  //       return Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
                  //             child: Text("Region", style: GoogleFonts.poppins(color: Color.fromRGBO(71, 69, 90, 1), fontWeight: FontWeight.w500, fontSize: 14),),
                  //           ),
                  //
                  //           DropdownButtonFormField(
                  //             value: RegionValue,
                  //             decoration: InputDecoration(
                  //                 focusedBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(10),
                  //                   borderSide: BorderSide(
                  //                       width: 2,
                  //                       color: Color.fromRGBO(71, 69, 90, 1)
                  //                   ),
                  //                 ),
                  //                 fillColor: Color.fromRGBO(71, 69, 90, 0.1),
                  //                 filled: true,
                  //                 border: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(10),
                  //                   borderSide: BorderSide(
                  //                       color: Color.fromRGBO(71, 69, 90, 1)
                  //                   ),
                  //                 )
                  //             ),
                  //             items: regions.map<DropdownMenuItem<String>>((String value) {
                  //               return DropdownMenuItem<String>(
                  //                 value: value,
                  //                 child: Text(value),
                  //               );
                  //             }).toList(),
                  //             onChanged: (String? value) {
                  //               // This is called when the user selects an item.
                  //               setState(() {
                  //                 RegionValue = value;
                  //               });
                  //             },),
                  //
                  //           Padding(
                  //             padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
                  //             child: Text("City", style: GoogleFonts.poppins(color: Color.fromRGBO(71, 69, 90, 1), fontWeight: FontWeight.w500, fontSize: 14),),
                  //           ),
                  //
                  //           DropdownButtonFormField(
                  //             value: cities[0],
                  //             decoration: InputDecoration(
                  //                 focusedBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(10),
                  //                   borderSide: BorderSide(
                  //                       width: 2,
                  //                       color: Color.fromRGBO(71, 69, 90, 1)
                  //                   ),
                  //                 ),
                  //                 fillColor: Color.fromRGBO(71, 69, 90, 0.1),
                  //                 filled: true,
                  //                 border: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(10),
                  //                   borderSide: BorderSide(
                  //                       color: Color.fromRGBO(71, 69, 90, 1)
                  //                   ),
                  //                 )
                  //             ),
                  //             items: cities.map<DropdownMenuItem<String>>((String value) {
                  //               return DropdownMenuItem<String>(
                  //                 value: value,
                  //                 child: Text(value),
                  //               );
                  //             }).toList(),
                  //             onChanged: (String? value) {
                  //               // This is called when the user selects an item.
                  //               setState(() {
                  //                 CityValue = value;
                  //               });
                  //             },),
                  //
                  //           Padding(
                  //             padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
                  //             child: Text("Town", style: GoogleFonts.poppins(color: Color.fromRGBO(71, 69, 90, 1), fontWeight: FontWeight.w500, fontSize: 14),),
                  //           ),
                  //
                  //           DropdownButtonFormField(
                  //             value: towns[0],
                  //             decoration: InputDecoration(
                  //                 focusedBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(10),
                  //                   borderSide: BorderSide(
                  //                       width: 2,
                  //                       color: Color.fromRGBO(71, 69, 90, 1)
                  //                   ),
                  //                 ),
                  //                 fillColor: Color.fromRGBO(71, 69, 90, 0.1),
                  //                 filled: true,
                  //                 border: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(10),
                  //                   borderSide: BorderSide(
                  //                       color: Color.fromRGBO(71, 69, 90, 1)
                  //                   ),
                  //                 )
                  //             ),
                  //             items: towns.map<DropdownMenuItem<String>>((String value) {
                  //               return DropdownMenuItem<String>(
                  //                 value: value,
                  //                 child: Text(value),
                  //               );
                  //             }).toList(),
                  //             onChanged: (String? value) {
                  //               // This is called when the user selects an item.
                  //               setState(() {
                  //                 TownValue = value;
                  //               });
                  //             },),
                  //         ],
                  //       );
                  //     } else {
                  //       return SizedBox();
                  //     }
                  //   },
                  // )

                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // void _loadFilterParams() {
  //   BlocProvider.of<FilterParamsCubit>(context).loadFilterParams();
  // }
}
