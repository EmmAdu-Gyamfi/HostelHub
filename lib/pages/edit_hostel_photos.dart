import 'package:flutter/material.dart';
import 'dart:convert';

import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hostel_hub_mobile_app/cubit/delete_hostel_photo/delete_hostel_photo_cubit.dart';
import 'package:hostel_hub_mobile_app/cubit/edit_hostel/edit_hostel_cubit.dart';
import 'package:hostel_hub_mobile_app/cubit/get_hostel/get_hostels_cubit.dart';
import 'package:hostel_hub_mobile_app/cubit/get_hostel/get_hostels_cubit.dart';
import 'package:hostel_hub_mobile_app/data/photo.dart';
import 'package:hostel_hub_mobile_app/pages/add_hostel_room_page.dart';
import 'package:hostel_hub_mobile_app/utilities/dialog_helper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../cubit/get_hostel_photos/hostel_photos_cubit.dart';
import '../cubit/upload_hostel_photo/upload_hostel_photo_cubit.dart';

import '../data/hostel.dart';
import '../utilities/my_navigator.dart';
import '../utilities/utils.dart';

class EditHostelPhotos extends StatefulWidget {


  final Hostel hostel;
  const EditHostelPhotos({Key? key, required this.hostel}) : super(key: key);

  @override
  State<EditHostelPhotos> createState() => _EditHostelPhotosState();
}

class _EditHostelPhotosState extends State<EditHostelPhotos> {
  ScrollController _scrollController = ScrollController();
  bool showFab = true;
  bool fixedShowFab = true;
  var coIndex;
  Uint8List pickedImage = Uint8List(8);
  late Hostel hostel;
  List<Photo> photos = [];
  bool _progressDialogShowing = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    hostel = widget.hostel;

    _getHostelPhotos();
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  Offset _tapPosition = Offset.zero;
  void _getTapPosition(TapDownDetails tapPosition) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(tapPosition.globalPosition);
      print(_tapPosition);
    });
  }

  void _showContextMenu(BuildContext context, TapDownDetails details, int fileId) async {
    final RenderObject? overlay =
    Overlay.of(context)?.context.findRenderObject();
    final result = await showMenu(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        elevation: 10,
        position:  RelativeRect.fromLTRB(
          details.globalPosition.dx,
          details.globalPosition.dy,
          details.globalPosition.dx,
          details.globalPosition.dy,
        ),
        items: [
          const PopupMenuItem(
            height: 20,

            child: Text('Delete'),
            value: "del",
          ),

        ]);
    // perform action on selected menu item
    switch (result) {
      case 'del':
        BlocProvider.of<DeleteHostelPhotoCubit>(context).deleteHostelPhoto(fileId);
        break;

    }
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery. of(context). size. width ;
    double screenHeight = MediaQuery. of(context). size. height;
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            _pickImage();
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          backgroundColor: primaryColor,
          icon: Icon(CupertinoIcons.photo_fill_on_rectangle_fill),
          label: Text("Add Image", style: GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white))),

      body: BlocListener<DeleteHostelPhotoCubit, DeleteHostelPhotoState>(
        listener: (context, state) {
          if(state is DeleteHostelPhotoSucceeded || state is DeleteHostelPhotoFailed) {
            if(_progressDialogShowing) {
              Navigator.of(context, rootNavigator: true).pop();
              _progressDialogShowing = false;
            }

            if (state is DeleteHostelPhotoSucceeded) {
              // setState((){
              //   photos = state.photos;
              // });

              DialogHelper.showSimpleSnackBar(context, "Photo deleted successfully");

              _getHostelPhotos();

            } else if (state is DeleteHostelPhotoFailed) {
              DialogHelper.showSimpleSnackBar(context, state.Message.toString());
            }
          } else {
            DialogHelper.showProgressDialog(context, message: "deleting photo...");
            _progressDialogShowing = true;
          }
        },
        child: Container(
        height: double.infinity,
        width: double.infinity,
        // color: Colors.yellow,
        child: Stack(
          children: [

            Container(
              // margin: EdgeInsets.only(top: screenHeight*0.1),
              height: double.infinity,
              width: double.infinity,
              // color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocListener<UploadHostelPhotoCubit, UploadHostelPhotoState>(
                  listener: (context, state) {
                    if(state is UploadHostelPhotoSucceeded || state is UploadHostelPhotoFailed) {
                      if(_progressDialogShowing) {
                        Navigator.of(context, rootNavigator: true).pop();
                        _progressDialogShowing = false;
                      }

                      if (state is UploadHostelPhotoSucceeded) {
                        // setState((){
                        //   photos = state.photos;
                        // });

                        DialogHelper.showSimpleSnackBar(context, "Photo uploaded successfully");

                        _getHostelPhotos();

                      } else if (state is UploadHostelPhotoFailed) {
                        DialogHelper.showSimpleSnackBar(context, state.message);
                      }
                    } else {
                      DialogHelper.showProgressDialog(context, message: "Uploading photo...");
                      _progressDialogShowing = true;
                    }
                  },
                  child: BlocBuilder<HostelPhotosCubit, GetHostelPhotosState>(
                    builder: (context, state){
                      if(state is HostelPhotosLoadingSucceeded){
                        photos = state.data;
                        if(photos.isEmpty){
                          return Padding(
                            padding: const EdgeInsets.only(bottom:100.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset("assets/emptyList.png", height: 500, width: 400,),
                                    Positioned(
                                      bottom: 80,
                                      child: Text("No Photos Found!",
                                        style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 55,
                                      child: Text("Looks like you haven't uploaded any photos yet!",
                                        style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 17),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          );
                        }



                        return GridView.custom(
                          gridDelegate: SliverWovenGridDelegate.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            pattern: [
                              WovenGridTile(1),
                              WovenGridTile(
                                5 / 7,
                                crossAxisRatio: 0.9,
                                alignment: AlignmentDirectional.centerEnd,
                              ),
                            ],
                          ),
                          childrenDelegate: SliverChildBuilderDelegate(
                            childCount: photos.length,
                                (context, index) {
                              var photo = photos[index];
                              return
                                  GestureDetector(
                                    onTapDown: (details) => {_showContextMenu(context, details, photo.fileId)},
                                    // onLongPress: ()=>{
                                    // _showContextMenu(context, details)
                                    // },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: CachedNetworkImage(
                                          fadeInDuration: Duration(microseconds: 500),
                                          fit: BoxFit.fill,
                                          imageUrl: "$baseUrl/FileStore/${photo.fileId}",
                                          httpHeaders: {
                                            "Accept": "application/json",
                                            "content-type":"application/json"
                                          },
                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                          placeholder: (context, string) => LoadingAnimationWidget.threeArchedCircle(color: Colors.black38, size: 30),
                                        ),
                                      ),
                                    ),
                                  );
                                  

                            },
                          ),
                        );
                      }
                      else if (state is HostelPhotosLoadingFailed){
                        return Center(
                          child: Text(state.message!),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                    },

                  ),
                ),
              ),
            )
          ],
        ),
      ),
),
    );
  }



  Future <void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if(image != null){

      var selectedImage = await image.readAsBytes();
      setState((){
        pickedImage = selectedImage;
      });
      BlocProvider.of<UploadHostelPhotoCubit>(context).uploadPhoto(image:pickedImage, hostelId: hostel.hostelId);

      // BlocBuilder<HostelPhotosCubit, HostelPhotosState>(
      //     builder: (context, state){
      //       if(state is UploadingHostelImageSucceeded){
      //          _getHostelPhotos();
      //       }
      //       return SnackBar(content: (Text("Uploading photo...")));
      //     }
      // );



    }
  }

  void _getHostelPhotos() {
    BlocProvider.of<HostelPhotosCubit>(context).loadHostelPhotos(hostel.hostelId);
  }

  Widget showAddPhotoFAB() {
    return
      FloatingActionButton.extended(
          onPressed: (){
            _pickImage();
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          backgroundColor: primaryColor,
          icon: Icon(CupertinoIcons.photo_fill_on_rectangle_fill),
          label: Text("Add Image", style: GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white)))
    ;
  }

  Widget showNextFAB() {
    return
      FloatingActionButton(
        onPressed: (){
          MyNavigator.navigateTo(context, AddHostelRoomMobilePage(hostelId: hostel.hostelId,));
        },
        child: Icon(Icons.arrow_forward),
        backgroundColor: primaryColor,)

    ;
  }


// void _getNewHostel() {
//
//   BlocBuilder<HostelsCubit, HostelsState>(builder: (context, state){
//     if(state is NewHostelRetrievalSucceeded){
//       var hostel =  state.hostel;
//       setState(() {
//         newHostel = hostel;
//       });
//
//
//     }
//     return Text("");
//   },);
// }
}
