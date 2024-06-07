part of 'get_hostel_reviews_cubit.dart';

abstract class GetHostelReviewsState extends Equatable {
  const GetHostelReviewsState();
  @override
  List<Object?> get props => [];
}

class GetHostelReviewsInitial extends GetHostelReviewsState {

}

class GetHostelReviewsInProgress extends GetHostelReviewsState {

}

class GetHostelReviewsSucceeded extends GetHostelReviewsState {
  final List<HostelReview> hostelReview;

  const GetHostelReviewsSucceeded(this.hostelReview);

  @override
  // TODO: implement props
  List<Object?> get props => [hostelReview];
}

class GetHostelReviewsFailed extends GetHostelReviewsState {
  final String? message;

  const GetHostelReviewsFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
