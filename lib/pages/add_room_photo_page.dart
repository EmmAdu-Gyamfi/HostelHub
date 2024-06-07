import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../cubit/get_room_photos/get_room_photos_cubit.dart';
import '../cubit/upload_room_photo/upload_room_photo_cubit.dart';
import '../data/hostel.dart';
import '../data/photo.dart';
import '../data/room.dart';
import '../utilities/dialog_helper.dart';
import '../utilities/my_navigator.dart';
import '../utilities/utils.dart';

class AddRoomPhotoMobilePage extends StatefulWidget {
  final Room room;
  const AddRoomPhotoMobilePage({Key? key, required this.room}) : super(key: key);

  @override
  State<AddRoomPhotoMobilePage> createState() => _AddRoomPhotoMobilePageState();
}

class _AddRoomPhotoMobilePageState extends State<AddRoomPhotoMobilePage> {
  ScrollController _scrollController = ScrollController();
  bool showFab = true;
  bool fixedShowFab = true;
  var coIndex;
  Uint8List  pickedImage = Uint8List(8);
  late Room room;
  List<Photo> photos = [];
  bool _progressDialogShowing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    room = widget.room;
    _getRoomPhotos();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery. of(context). size. width ;
    double screenHeight = MediaQuery. of(context). size. height;
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if(photos.length >= 3)...[
            showNextFAB()
          ],
          SizedBox(
            height: 10,
          ),
          if(showFab)...[
            showAddPhotoFAB()
          ]
        ],
      ),
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
              left: screenWidth*0.32,
              child: Text(
                "Room Images",
                style: GoogleFonts.roboto(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            // Positioned(
            //     top: screenHeight*0.054,
            //     left:16,
            //     child: InkWell(
            //         onTap: (){
            //           Navigator.pop(context);
            //         },
            //         child: Icon(Icons.arrow_back, color: Colors.white, size: 30,))),



            Container(
              margin: EdgeInsets.only(top: screenHeight*0.1),
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocListener<UploadRoomPhotoCubit, UploadRoomPhotoState>(
                    listener: (context, state) {
                      if(state is UploadRoomPhotoSucceeded || state is UploadRoomPhotoFailed) {
                        if(_progressDialogShowing) {
                          Navigator.of(context, rootNavigator: true).pop();
                          _progressDialogShowing = false;
                        }

                        if (state is UploadRoomPhotoSucceeded) {
                          // setState((){
                          //   photos = state.photos;
                          // });

                          DialogHelper.showSimpleSnackBar(context, "Photo uploaded successfully");

                          _getRoomPhotos();

                        } else if (state is UploadRoomPhotoFailed) {
                          DialogHelper.showSimpleSnackBar(context, state.message);
                        }
                      } else {
                        DialogHelper.showProgressDialog(context, message: "Uploading photo...");
                        _progressDialogShowing = true;
                      }
                    },
                    child: BlocBuilder<GetRoomPhotosCubit,GetRoomPhotosState>(
                      builder: (context, state){
                        if(state is RoomPhotosLoadingSucceeded){
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
                                return Container(
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
                                );
                              },
                            ),
                          );
                        }
                        else if (state is RoomPhotosLoadingFailed){
                          return Center(
                            child: Text(state.Message!),
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
              ),
            )
          ],
        ),
      ),
    );
  }

  void _getRoomPhotos() {
    BlocProvider.of<GetRoomPhotosCubit>(context).loadRoomPhotos(room.roomId);
  }


  Future <void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if(image != null){

      var selectedImage = await image.readAsBytes();
      setState((){
        pickedImage = selectedImage;
      });
      BlocProvider.of<UploadRoomPhotoCubit>(context).uploadPhoto(image:pickedImage, roomId: room.roomId);

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
          // MyNavigator.navigateTo(context, AddHostelRoomMobilePage(hostelId: hostel.hostelId,));
        },
        child: Icon(Icons.arrow_forward),
        backgroundColor: primaryColor,)

    ;
  }


  }


