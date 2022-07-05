import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_details.dart';

class UserProvider {
  final sharedPreferences = SharedPreferences.getInstance();

  Future<UserDetalils> loadValue() async {
    final list = (await sharedPreferences).getStringList('list');

    final name = list?[0];
    final photo = list?[1];
    final mail = list?[2];

    final object = UserDetalils(displaiyName: name , email: mail, photoUrl: photo);

    print(object);
    print('1');
    return object;
  }

  Future<void> saveValue(UserDetalils user) async {
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
