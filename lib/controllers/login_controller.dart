import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_tutorial/model/user_details.dart';
import 'package:login_tutorial/provider/provider.dart';

class LoginController with ChangeNotifier {
    UserProvider? userProvider;

  var _googleSignin = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserDetalils? userDetalils;


  // Future<UserDetalils?> initialize() async {
  //   final photos = await userProvider?.loadValue();
  //   return photos;
  // }

  googleLogin() async {
    this.googleSignInAccount = await _googleSignin.signIn();
   final goog = this.userDetalils = new UserDetalils(
      displaiyName: this.googleSignInAccount!.displayName,
      email: this.googleSignInAccount!.email,
      photoUrl: this.googleSignInAccount!.photoUrl,
    );
    userProvider?.saveValue(goog);
    notifyListeners();
  }

  facebooklogin() async {
    var result = await FacebookAuth.i.login(
      permissions: ['public_profile', 'email'],
    );

    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: 'email, name, picture',
      );

     final fb = this.userDetalils = new UserDetalils(
        displaiyName: requestData['name'],
        email: requestData['email'],
        photoUrl: requestData['picture']['data']['url'] ?? '',
      );
      userProvider?.saveValue(fb);
      notifyListeners();
    }
  }


    logout() async {
      this.googleSignInAccount = await _googleSignin.signOut();
      await FacebookAuth.i.logOut();
      userDetalils = null;
      notifyListeners();
    }
  }
