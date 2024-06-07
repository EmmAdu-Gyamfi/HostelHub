import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hostel_hub_mobile_app/pages/dialog_progress.dart';
import 'package:hostel_hub_mobile_app/utilities/dimensions.dart';
import 'package:hostel_hub_mobile_app/utilities/utils.dart';
import 'package:sweetsheet/sweetsheet.dart';

import '../pages/dialog_progress.dart';

class DialogHelper {


  static Flushbar showSimpleSnackBar(BuildContext context, String message, {  Duration duration = const Duration(seconds: 3), flushbarPosition = FlushbarPosition.BOTTOM,}) {
    var flush = Flushbar(
      backgroundColor: primaryColor,
      message: message,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      barBlur: 0.9,
      flushbarPosition: flushbarPosition,
      duration: duration,
    );
    flush..show(context);
    return flush;
  }

  static void showActionSnackBar(BuildContext context, String message,
      OnTap? onTap) {
    Flushbar(
      backgroundColor: primaryColor,
      message: message,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      duration: Duration(seconds: 3),
      onTap: onTap,
    )
      ..show(context);
  }

  static Future showSimpleModalBottomSheet(BuildContext context, { required Widget child, bool isScrollControlled = false, bool barrierDismissible = true }){
    return showModalBottomSheet(
        backgroundColor: primaryColor,
        context: context,
        isDismissible: barrierDismissible,
        isScrollControlled: isScrollControlled,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(cardRadius))),
        builder: (context) {
          return SafeArea(
            bottom: false,
            child:  child,
          );
        });
  }

  static Future showProgressDialog<T>(BuildContext context, { required String message, bool barrierDismissible = false }){
    return showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return DialogProgress(message);
        }
    );
  }

  static Flushbar showButtonSnackBar(BuildContext context, String message,
      Widget mainButton) {
   return Flushbar(
      message: message,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      mainButton: mainButton,
      // onTap: action,
    )
      ..show(context);
  }

  static void showSweetSheet(
      BuildContext context, {
        required String title,
        required String message,
        SweetSheetAction? positiveAction,
        SweetSheetAction? negativeAction,
        bool isDismissible = true,
        IconData? iconData
      }) {

    // if(negativeAction == null){
    //   negativeAction = SweetSheetAction(
    //     onPressed: (){
    //       Navigator.of(context).pop();
    //     },
    //     title: 'CANCEL',
    //   );
    // }

    positiveAction ??= SweetSheetAction(
        onPressed: (){
          Navigator.of(context).pop();
        },
        title: 'OK',
      );

    var themeData = Theme.of(context);

    SweetSheet().show(
      context: context,
      title: Text(title),
      description: Text(
          message),
      color: CustomSheetColor(main: themeData.primaryColor.withOpacity(0.9), accent: themeData.primaryColor, icon: Colors.white),
      icon: iconData,
      isDismissible: isDismissible,
      positive: positiveAction,
      negative: negativeAction,
    );
  }

  // static void showActionSnackBar(BuildContext context, String message,
  //     Function action) {
  //   Flushbar(
  //     message: message,
  //     margin: EdgeInsets.all(8),
  //     borderRadius: BorderRadius.circular(8),
  //     duration: Duration(seconds: 3),
  //     onTap: action,
  //   )
  //     ..show(context);
  // }

//   static Future<T> showSimpleDialog<T>(BuildContext context, { String title = "", String message, List<DialogButton> dialogButtons, bool isDismissible = true }) {
//     if (dialogButtons == null) {
//       dialogButtons = [
//         DialogButton(
//             buttonLabel: "OK",
//             onPressed: () => Navigator.of(context).pop()
//         )
// //        FlatButton(
// //          child: Text("OK"),
// //          onPressed: () => Navigator.of(context).pop(),
// //        )
//       ];
//     }
//
//     List<Widget> actions = new List<Widget>();
//
//     dialogButtons.forEach((dialogButton) {
//       if(Platform.isIOS){
//         actions.add( CupertinoButton(
//           child: Text(dialogButton.buttonLabel),
//           onPressed: dialogButton.onPressed,
//         ));
//       } else {
//         actions.add(FlatButton(
//           child: Text(dialogButton.buttonLabel, style: TextStyle(color: MyColors.primaryColor),),
//           onPressed: dialogButton.onPressed,
//         ));
//       }
//     });
//
//     Widget dialog;
//     Text content = message == null ? null : message.isEmpty ? null : Text(message);
//
//     if(Platform.isIOS) {
//       dialog = CupertinoAlertDialog(
//           title: title.isEmpty ? null : Text(title),
//           content: content,
//           actions: actions
//       );
//     } else {
//       dialog = AlertDialog(
//           title: title.isEmpty ? null :  Text(title),
//           content: content,
//           actions: actions,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(MyDimens.dialogCornerRadius)
//           )
//       );
//     }
//
//     return showDialog(
//         context: context,
//         barrierDismissible: isDismissible,
//         builder: (context) {
//           return dialog;
//         }
//     );
//   }

  // static Future<T> showProgressDialog<T>(BuildContext context, { @required String message, bool barrierDismissible = false }){
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: barrierDismissible,
  //       builder: (context) {
  //         return DialogProgress(message);
  //       }
  //   );
  // }
}


// class DialogButton {
//   final String buttonLabel;
//   final VoidCallback onPressed;
//
//   DialogButton({@required this.buttonLabel, @required this.onPressed});
// }