

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_tutorial/model/user_details.dart';
import 'package:login_tutorial/provider/provider.dart';

import '../main.dart';

class LoginController with ChangeNotifier {
  UserP userP = UserP();
  UserProvider userProvider = UserProvider();
  var _googleSignin = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserDetalils? userDetalils;

  Future<UserDetalils?> initialize() async {
    final photos = await userP.user?.loadValue();
    return photos;
  }

  googleLogin() async {
    googleSignInAccount  = await _googleSignin.signIn();
    final goog =  userDetalils = await UserDetalils(
      displaiyName: googleSignInAccount?.displayName,
      email: googleSignInAccount?.email,
      photoUrl: googleSignInAccount?.photoUrl,
    );
   // final id = await userP.user?.saveValue(goog);
   final id = await userProvider.saveValue(goog);
    print(id);
    print('3443');
    notifyListeners();
    return id;

  }

  facebooklogin() async {
    var result = await FacebookAuth.i.login(
      permissions: ['public_profile', 'email'],
    );

    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: 'email, name, picture',
      );

      final fb = userDetalils = UserDetalils(
        displaiyName: requestData['name'] ?? '',
        email: requestData['email'] ?? '',
        photoUrl: requestData['picture']['data']['url'] ?? '',
      );
      final idd = userP.user?.saveValue(fb);
      print(idd);
      print(111);
      notifyListeners();
    }
  }

  logout() async {
    googleSignInAccount = await _googleSignin.signOut();
    await FacebookAuth.i.logOut();
    userDetalils = null;
    notifyListeners();
  }
}