part of 'add_hostel_review_cubit.dart';

abstract class AddHostelReviewState extends Equatable {
  const AddHostelReviewState();

  @override
  List<Object?> get props => [];
}

class AddHostelReviewInitial extends AddHostelReviewState {

}


class AddHostelReviewInProgress extends AddHostelReviewState {

}

class AddHostelReviewSucceeded extends AddHostelReviewState {

}

class AddHostelReviewsFailed extends AddHostelReviewState {
  final String? message;

  const AddHostelReviewsFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
