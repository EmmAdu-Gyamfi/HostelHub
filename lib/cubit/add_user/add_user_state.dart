part of 'add_user_cubit.dart';

abstract class AddUserState extends Equatable {
  const AddUserState();
  @override
  List<Object?> get props => [];
}

class AddUserInitial extends AddUserState {

}

class AddUserInProgress extends AddUserState{

}

class AddUserSucceeded extends AddUserState{

}

class AddUserFailed extends AddUserState{
  final String? Message;

  AddUserFailed(this.Message);

  @override
  // TODO: implement props
  List<Object?> get props => [Message];
}
