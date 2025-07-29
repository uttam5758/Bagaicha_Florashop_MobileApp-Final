import 'package:flutter/material.dart';

import '../presentation/view/signin.dart';

class Logo extends StatefulWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = CurvedAnimation(parent: controller!, curve: Curves.easeIn);
    controller!.forward();

    animation!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignIn(),
              ));
        });
      } else if (status == AnimationStatus.dismissed) {
        controller!.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: FadeTransition(
          opacity: animation!,
          child: const Text(
            "CyberShop",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35.0,
                color: Colors.white,
                fontFamily: "Ki"),
          ),
        ),
      ),
    );
  }
}
