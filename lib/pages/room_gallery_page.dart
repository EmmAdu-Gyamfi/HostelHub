import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../data/hostel.dart';
import '../utilities/utils.dart';

class RoomGalleryMobilePage extends StatefulWidget {
  final List<RoomPhotos> photos ;
  const RoomGalleryMobilePage({Key? key, required this.photos}) : super(key: key);

  @override
  State<RoomGalleryMobilePage> createState() => _RoomGalleryMobilePageState();
}

class _RoomGalleryMobilePageState extends State<RoomGalleryMobilePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery. of(context). size. width ;
    double screenHeight = MediaQuery. of(context). size. height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: screenWidth,
              height: screenHeight*0.4,
              color: Colors.red,
              child: ImageSlideshow(
                isLoop: true,
                indicatorColor: Colors.blue,
                children: _getImages(),
              ),
            ),

            Positioned(
                top: 16,
                left: 16,
                child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.white,)))
          ],
        ),
      ),
    );
  }
  List<CachedNetworkImage> _getImages() {
    var images = widget.photos.map((e) => CachedNetworkImage(
      fadeInDuration: Duration(microseconds: 0),
      useOldImageOnUrlChange: true,
      fit: BoxFit.fill,
      width: double.infinity,
      imageUrl: "$baseUrl/FileStore/${e.fileId}",
      httpHeaders: {
        "Accept": "application/json",
        "content-type":"application/json"
      },
      errorWidget: (context, url, error) => Icon(Icons.error),
      placeholder: (context, string) => Container(color: Colors.grey,child: LoadingAnimationWidget.threeArchedCircle(color: Colors.white, size: 30)),
    ),).toList();
    return images;
  }
}

