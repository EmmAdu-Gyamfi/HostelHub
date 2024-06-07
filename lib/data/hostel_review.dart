class HostelReview {
  HostelReview({
    // required this.hostelReviewId,
    required this.comment,
    required this.hostelId,
    required this.userId,
    required this.sentiment,
    required this.date,
    required this.userName,


  });
  late final int hostelReviewId;
  late final String comment;
  late final int hostelId;
  late final int userId;
  late final String sentiment;
  late final String date;
  late final String userName;


  HostelReview.fromJson(Map<String, dynamic> json){
    hostelReviewId = json['hostelReviewId'];
    comment = json['comment'];
    hostelId = json['hostelId'];
    userId = json['userId'];
    sentiment = json['sentiment'];
    date = json['date'];
    userName = json['userName'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hostelReviewId'] = hostelReviewId;
    _data['comment'] = comment;
    _data['hostelId'] = hostelId;
    _data['userId'] = userId;
    _data['sentiment'] = sentiment;
    _data['date'] = date;
    _data['userName'] = userName;

    return _data;
  }
}