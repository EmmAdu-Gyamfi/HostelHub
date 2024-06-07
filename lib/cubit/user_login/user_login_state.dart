part of 'user_login_cubit.dart';

abstract class UserLoginState extends Equatable {
  const UserLoginState();
  @override
  List<Object?> get props => [];
}

class UserLoginInitial extends UserLoginState {

}

class UserLoginInProgress extends UserLoginState{

}

class UserLoginSucceeded extends UserLoginState{
final AppUser CurrentUser;
UserLoginSucceeded(this.CurrentUser);
@override
  // TODO: implement props
    List<Object?> get props => [CurrentUser];
}

class UserLoginFailed extends UserLoginState{
final String Message;

UserLoginFailed(this.Message);

@override
  // TODO: implement props
  List<Object?> get props => [Message];
}

