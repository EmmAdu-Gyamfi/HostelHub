import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub_mobile_app/cubit/add_hostel_review/add_hostel_review_cubit.dart';
import 'package:hostel_hub_mobile_app/cubit/get_hostel_reviews/get_hostel_reviews_cubit.dart';
import 'package:hostel_hub_mobile_app/data/hostel.dart';
import 'package:hostel_hub_mobile_app/data/hostel_review.dart';
import 'package:hostel_hub_mobile_app/pages/feedback_page.dart';
import 'package:hostel_hub_mobile_app/utilities/my_navigator.dart';

import '../utilities/utils.dart';

class AddFeedBackPage extends StatefulWidget {
  Hostel hostel;
  var userId;
  String userName;
  AddFeedBackPage({super.key, required this.hostel, required this.userId, required this.userName});

  @override
  State<AddFeedBackPage> createState() => _AddFeedBackPageState();
}

class _AddFeedBackPageState extends State<AddFeedBackPage> {
  String? sentimentValue = "Positive";
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose(){

    _commentController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    List<String> sentimentList = <String>['Positive', 'Neutral', 'Negative'];

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          label: Text("Save", style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),),
          backgroundColor:  primaryColor,
        elevation: 20,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
    ),
    icon: Icon(CupertinoIcons.floppy_disk, size: 22,),
    onPressed: ()  {
            HostelReview hostelReview = HostelReview(
                comment: _commentController.text,
                hostelId: widget.hostel.hostelId,
                userId: widget.userId,
                sentiment: sentimentValue.toString(),
                userName: widget.userName,
                date: DateTime.now().toString(),
            );

            BlocProvider.of<AddHostelReviewCubit>(context).addFeedback(hostelReview);
            // Future.delayed(Duration(seconds: 5));
            Navigator.pop(context);
            // MyNavigator.navigateTo(context, FeedbackPage());
            // BlocProvider.of<GetHostelReviewsCubit>(context).loadReview(widget.hostel.hostelId);



    }
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text("Adding Feedback on ${widget.hostel.name}", style: GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.bold),),
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
                child: Text("How was your experience?", style: GoogleFonts.poppins(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),),
              ),
            ),
            Divider(thickness: 1,),
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
              child: Text("Sentiment", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
            ),
            DropdownButtonFormField(
              value: sentimentValue,
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
              items: sentimentList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  sentimentValue = value;
                });
              },),

            Padding(
              padding: const EdgeInsets.only(bottom: 6.0, left: 8, top: 16),
              child: Text("Feedback", style: GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
            ),
            TextField(
              onChanged: (value) => setState(() {

              }),
              controller: _commentController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              cursorColor: Color.fromRGBO(71, 69, 90, 1),
              cursorWidth: 1,
              decoration: InputDecoration(
                  counterText: "${_commentController.text.length}/200",
                  errorText:validateComment(_commentController.text),
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
    );
  }
}
String? validateComment(String value) {
  if (value.isEmpty) {
    return "This field is required";
  }
}
