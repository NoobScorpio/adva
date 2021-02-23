import 'package:adva/data/model/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {}

class UserInitialState extends UserState {
  UserInitialState();
  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UserLoadedState extends UserState {
  final User user;

  UserLoadedState({this.user});

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class UserErrorState extends UserState {
  final String message;

  UserErrorState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class UserLoggedInState extends UserState {
  final bool loggedIn;

  UserLoggedInState(this.loggedIn);

  @override
  // TODO: implement props
  List<Object> get props => [loggedIn];
}

class GetUserLoggedInState extends UserState {
  final User user;

  GetUserLoggedInState({this.user});

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class UserCreatedState extends UserState {
  final bool created;

  UserCreatedState({this.created});

  @override
  // TODO: implement props
  List<Object> get props => [created];
}

class UserUpdatedLoadedState extends UserState {
  final bool updated;

  UserUpdatedLoadedState({this.updated});

  @override
  // TODO: implement props
  List<Object> get props => [updated];
}

class UserPassChangeState extends UserState {
  final bool updated;

  UserPassChangeState({this.updated});

  @override
  // TODO: implement props
  List<Object> get props => [updated];
}
