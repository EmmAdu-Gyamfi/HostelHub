import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub_mobile_app/cubit/add_hostel_review/add_hostel_review_cubit.dart';
import 'package:hostel_hub_mobile_app/cubit/get_hostel_reviews/get_hostel_reviews_cubit.dart';
import 'package:hostel_hub_mobile_app/pages/add_feedback_page.dart';
import 'package:hostel_hub_mobile_app/utilities/my_navigator.dart';
import 'package:hostel_hub_mobile_app/utilities/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/hostel.dart';
import '../utilities/dialog_helper.dart';

class FeedbackPage extends StatefulWidget {
  Hostel hostel;
  FeedbackPage({super.key, required this.hostel});
  var userId;
   var userName;


  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  bool _progressDialogShowing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserId();
    _loadReviews();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocListener<AddHostelReviewCubit, AddHostelReviewState>(
      listener: (context, state) {
        if(state is AddHostelReviewSucceeded || state is AddHostelReviewsFailed) {
          if(_progressDialogShowing) {
            Navigator.of(context, rootNavigator: true).pop();
            _progressDialogShowing = false;
          }

          if (state is AddHostelReviewSucceeded) {
            setState(() {
              _loadReviews();
            });
          } else if (state is AddHostelReviewsFailed) {
            DialogHelper.showSimpleSnackBar(context, state.message.toString());
          }
        } else {
          DialogHelper.showProgressDialog(context, message: "Adding new feedback...");
          _progressDialogShowing = true;
        }
      },
      child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          MyNavigator.navigateTo(context, AddFeedBackPage(hostel: widget.hostel, userId: widget.userId, userName: widget.userName,)).then((res) {
            // _loadReviews();
         });
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add_comment),

      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text("Feedbacks on ${widget.hostel.name}", style: GoogleFonts.roboto(fontSize: 19, fontWeight: FontWeight.bold),),
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body:  BlocBuilder<GetHostelReviewsCubit, GetHostelReviewsState>(
          builder: (context, state){
           if(state is GetHostelReviewsSucceeded){
             var reviews = state.hostelReview;
             if(reviews.isEmpty){
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
                           child: Text("No Feedbacks Found!",
                             style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
                           ),
                         ),
                         Positioned(
                           bottom: 55,
                           child: Text("Looks like nobody has given a feedback yet!",
                             style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 17),
                           ),
                         ),
                       ],
                     ),

                   ],
                 ),
               );
             }
             else{
               return ListView.builder(
                   itemCount: reviews.length,
                   itemBuilder: (context, index){
                     var date = DateTime.parse("${reviews[index].date}");
                     var formattedDate = "${date.day}-${date.month}-${date.year}";
                     return Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                         width: double.infinity,
                         // height: 100,
                         decoration: BoxDecoration(
                             color: Color.fromRGBO(206, 207, 217, 1),
                             borderRadius: BorderRadius.circular(10)
                         ),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Row(
                                 children: [
                                   Container(
                                     alignment: Alignment.center,
                                     width: 35,
                                     height: 35,
                                     decoration: BoxDecoration(
                                         color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                         shape: BoxShape.circle
                                     ),
                                     child: Text("${reviews[index].userName[0].toUpperCase()}",
                                       style: GoogleFonts.poppins(
                                           color: Colors.white,
                                           fontWeight: FontWeight.normal,
                                           fontSize: 16)
                                       ,),
                                   ),
                                   SizedBox(width: 8,),
                                   Container(
                                     child: Text("${reviews[index].userName.capitalize}", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 17),),
                                   ),
                                   Spacer(),
                                   reviews[index].sentiment == "Positive" ? Icon(Icons.sentiment_satisfied_alt, color: Colors.green,size: 30,): reviews[index].sentiment == "Neutral" ? Icon(Icons.sentiment_neutral_outlined, color: Colors.orange, size: 30) : Icon(Icons.sentiment_dissatisfied_outlined, color: Colors.red, size: 30)
                                 ],
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(top: 0.0, left: 10, right: 10,bottom: 0),
                               child: Container(
                                 child: Text("${reviews[index].comment}", style: GoogleFonts.roboto(fontSize: 16),),
                               ),
                             ),

                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Container(
                                 child: Text("${formattedDate}", style: GoogleFonts.roboto(fontSize: 14),),
                               ),
                             )
                           ],
                         ),
                       ),
                     );
                   }
               );
             }

             // Padding(
             //   padding: const EdgeInsets.all(8.0),
             //   child: Container(
             //     width: double.infinity,
             //     height: 50,
             //     color: Colors.red,
             //   ),
             // );
           } else if(state is GetHostelReviewsFailed){
             return Center(child: Text("${state.message}"));
           }
           return Center(child: CircularProgressIndicator());
          }
      ),

    ),
);
  }

  Future<void> _loadUserId() async{
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.userId = int.parse(prefs.getString('userId').toString());
    widget.userName = prefs.getString('userName').toString();

  }

  void _loadReviews() {
    BlocProvider.of<GetHostelReviewsCubit>(context).loadReview(widget.hostel.hostelId);
  }


}
