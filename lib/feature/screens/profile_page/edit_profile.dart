import 'package:cybershop/models/userModel.dart';
import 'package:cybershop/repository/userRepository.dart';
import 'package:cybershop/feature/screens/profile_page/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class EditProfile extends StatefulWidget {
  final String? image;
  const EditProfile({super.key, this.image});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController names = TextEditingController();
  TextEditingController email = TextEditingController();
  _updateUser(String? name, String? email) async {
    bool isLogin = await UserRepository().updateProfile(name, email);
    if (isLogin) {
      Navigator.popAndPushNamed(context, '/signin');
    } else {
      _displayMessage(false);
    }
  }

  _displayMessage(msg) {
    if (msg) {
      MotionToast.success(description: const Text('success register'))
          .show(context);
    } else {
      MotionToast.warning(description: const Text('error rergister'))
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ModalRoute.of(context)!.settings.arguments as Map;
    final namess = profile['name'];
    final emailr = profile['email'];

    names.text = namess;
    email.text = emailr;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        elevation: 4.0,
        centerTitle: true,
        // backgroundColor: const Color.fromARGB(255, 14, 234, 117),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50.0),
          child: Stack(children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 80.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 214, 227, 198),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                        top: 100.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: names,
                          decoration: InputDecoration(
                            labelText: 'Names',
                            prefixIcon: const Icon(Icons.person),
                            border: myInputBorder(),
                            enabledBorder: myInputBorder(),
                            focusedBorder: myFocusBorder(),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextField(
                          controller: email,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.email),
                            border: myInputBorder(),
                            enabledBorder: myInputBorder(),
                            focusedBorder: myFocusBorder(),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            _updateUser(names.text, email.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 14, 234, 117),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text('Update Profile'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: <Widget>[
                  ClipOval(
                    child: Image.asset(
                      'assets/image/profile.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 15.5,
                    child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(150),
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 30,
                        )),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  OutlineInputBorder myInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 3.0,
      ),
    );
  }

  OutlineInputBorder myFocusBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 73, 40, 40),
        width: 3.0,
      ),
    );
  }
}
