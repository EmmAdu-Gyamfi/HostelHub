import 'package:flutter/material.dart';
import 'package:hostel_hub_mobile_app/utilities/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget moblieBody;

  final Widget desktopBody;

  const ResponsiveLayout({Key? key, required this.moblieBody, required this.desktopBody}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      if(constraints.maxWidth < mobileWidth){
        return moblieBody;
      } else{
        return desktopBody;
      }
    });
  }
}
