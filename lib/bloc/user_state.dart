part of 'user_bloc.dart';


abstract class UserState {}

class LoadingState extends UserState {}

class LoadedState extends UserState {
 final List<UserDetalils> userList;

  LoadedState(this.userList);
}