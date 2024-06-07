part of 'add_hostel_cubit.dart';

abstract class AddHostelState extends Equatable {
  const AddHostelState();

  @override
  List<Object?> get props => [];
}

class AddHostelInitial extends AddHostelState {
}

class AddHostelInProgress extends AddHostelState {}

class AddHostelFailed extends AddHostelState {

  final String message;

  AddHostelFailed(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class AddHostelSucceeded extends AddHostelState {
  final Hostel data;
  AddHostelSucceeded(this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}