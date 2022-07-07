import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_details.dart';

class UserProvider {
  final sharedPreferences = SharedPreferences.getInstance();

  Future<UserDetalils> loadValue() async {
    final list = (await sharedPreferences).getStringList('list');

    final name = list?[0];
    final photo = list?[1];
    final mail = list?[2];

    final object =
    UserDetalils(displaiyName: name, email: mail, photoUrl: photo);

    print(object.displaiyName);
    // print(object.email);
    // print(object.photoUrl);
    // print('1');
    // (await sharedPreferences).remove('list');
    return object;
  }

  saveValue(UserDetalils user) async {
    final name = user.displaiyName ?? '';
    final photo = user.photoUrl ?? '';
    final mail = user.email ?? '';
    final list = [photo, name, mail];
    print(list);
    print('2');
    (await sharedPreferences).setStringList('list', list);
    final out = (await sharedPreferences).getStringList('list');
    print(out);
  }
}

// class User extends ChangeNotifier {
//   String? displaiyName;
//   String? email;
//   String? photoUrl;
//
//   User({this.displaiyName, this.email, this.photoUrl});
//
//   User.fromJson(Map<String, dynamic> json) {
//     displaiyName = json['displaiyName'];
//     photoUrl = json['displaiyName'];
//     email = json['email'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['displaiyName'] = this.displaiyName;
//     data['photoUrl'] = this.photoUrl;
//     data['email'] = this.email;
//
//     return data;
//   }
//
//   final sh = SharedPreferences.getInstance();
//
//   login(User user) async {
//     final list = <String>[
//       user.displaiyName ?? '',
//       user.email ?? '',
//       user.photoUrl ?? ''
//     ];
//     (await sh).setStringList('list', list);
//   }
//
//   logout(String key) async {
//     (await sh).remove(key);
//   }
//
//   getUser() async{}
// }
class UserP  extends ChangeNotifier {
   UserProvider? _user;
  UserProvider? get user => _user;
  setUser(UserProvider user) {
    _user = user;
    notifyListeners();
  }

}