import 'package:cybershop/models/userModel.dart';
import 'package:cybershop/repository/userRepository.dart';
import 'package:cybershop/wearOs/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:wear/wear.dart';

class WearOsLogin extends StatefulWidget {
  const WearOsLogin({Key? key}) : super(key: key);
  @override
  State<WearOsLogin> createState() => _WearOsLoginState();
}

class _WearOsLoginState extends State<WearOsLogin> {
  _navigateToScreen(bool isLogin) {
    if (isLogin) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AllProduct();
      }));
    } else {}
  }

  _loginUser(User user) async {
    try {
      UserRepository userRepository = UserRepository();

      bool isLogin = await userRepository.loginUser(user);

      if (isLogin) {
        _navigateToScreen(true);
      } else {
        _navigateToScreen(false);
      }
    } catch (e) {}
  }

  final email = TextEditingController();
  final password = TextEditingController();
  int result = 0;

  @override
  Widget build(BuildContext context) {
    return WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
      return AmbientMode(
        builder: (context, mode, child) {
          return Scaffold(
              body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: email,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            // hintText: 'username',
                            // hintStyle: TextStyle(fontSize: 10),
                            labelText: 'Username',
                            labelStyle: TextStyle(fontSize: 10),
                          ),
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: password,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                            hintStyle: TextStyle(fontSize: 10),
                            labelText: ' Password',
                            labelStyle: TextStyle(fontSize: 10),
                          ),
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              User user = User(
                                email: email.text,
                                password: password.text,
                              );
                              _loginUser(user);
                            },
                            child: const Text("login")),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ));
        },
      );
    });
  }
}
