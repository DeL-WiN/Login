
import 'package:flutter/material.dart';
import 'package:login_tutorial/controllers/login_controller.dart';
import 'package:login_tutorial/provider/provider.dart';
import 'package:provider/provider.dart';

import 'model/user_details.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final _userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ttttt'),
        centerTitle: true,
          backgroundColor: Colors.indigo,
      ),
      body: loginUI(

      ),
    );
  }

 Widget loginUI() {

    return Consumer<LoginController> (
      builder: (context, model, child) {
        if(model.userDetalils != null) {
          return Center(
            child: loggedInUI(model),
          );
        }else {
          return cash();
        }
      }
    );
  }

  cash() {
    // final users = LoginController().initialize();
    return Consumer<LoginController>(
        builder: (context, model, child) {
          if (model.userProvider.loadValue() != null) {
            return  Center(
              child:  loggedInUI(model),
            );
          } else {
            return loginControllers(context);
          }
        }
    );
  }



  loggedInUI(LoginController model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: Image.network(model.userDetalils?.photoUrl ?? '').image,
          radius: 50,
        ),
        Text(model.userDetalils?.displaiyName ?? ''),
        Text(model.userDetalils?.email ?? ''),

        ActionChip(
            avatar: Icon(Icons.logout),
            label: Text('Logout'),
            onPressed: () {
              Provider.of<LoginController>(context, listen: false).logout();
            }
        ),
      ],
    );

    }
  }

  loginControllers(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Image.asset('assets/images/google.jpg',
            width: 240,),
            onTap: () {
              Provider.of<LoginController>(context, listen: false).googleLogin();
            },
          ),
          SizedBox(height: 10,),
          GestureDetector(
            child: Image.asset('assets/images/fb.jpg',
              width: 240,),
            onTap: () {
              Provider.of<LoginController>(context, listen: false).facebooklogin();
            },
          ),
        ],
      ),
    );
  }

