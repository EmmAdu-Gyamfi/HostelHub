part of 'edit_hostel_cubit.dart';

abstract class EditHostelState extends Equatable {
  const EditHostelState();
  @override
  List<Object?> get props => [];
}

class EditHostelInitial extends EditHostelState {

}



class EditHostelInProgress extends EditHostelState{

}

class EditHostelSucceeded extends EditHostelState{

}

class EditHostelFailed extends EditHostelState{
  final String? Message;

  EditHostelFailed(this.Message);

  @override
  // TODO: implement props
  List<Object?> get props => [Message];
}
