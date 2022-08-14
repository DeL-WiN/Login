import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/user_details.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  var _googleSignin = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserDetalils userDetalils = UserDetalils();

  UserBloc(super.initialState){
    on<UserEvent>((event, emit) {
      if (event is LoadingEvent) {
        return _loadUser(event, emit);
      }
    });
  }

  Future<void> _loadUser(UserEvent event, Emitter<UserState> emit) async {


    final _state = state;
    if (_state is LoadedState) {
      googleSignInAccount  = await _googleSignin.signIn();
      final goog =  userDetalils = await UserDetalils(
        displaiyName: googleSignInAccount?.displayName,
        email: googleSignInAccount?.email,
        photoUrl: googleSignInAccount?.photoUrl,
      );

      // final id = await userProvider.saveValue(goog);
      // emit(LoadedState(goog));
    }
  }

}