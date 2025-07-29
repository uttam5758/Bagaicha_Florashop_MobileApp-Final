import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cybershop/models/userModel.dart';
import 'package:cybershop/repository/userRepository.dart';
import 'package:cybershop/feature/screens/animation.dart';
import 'package:cybershop/feature/screens/navigation_screen.dart';
import 'package:cybershop/feature/presentation/view/signout.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  void autoLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token != null && token.isNotEmpty) {
      _navigateToScreen(true);
    }
  }

  void _navigateToScreen(bool isLogin) {
    if (isLogin) {
      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });

      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          title: 'Sign In',
          body: "Welcome to Bagaicha Florashop!",
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => NavigationDrawers()),
        (route) => false,
      );
    } else {
      MotionToast.error(
        description: const Text("Incorrect email or password"),
      ).show(context);
    }
  }

  void _loginUser(User user) async {
    try {
      UserRepository userRepository = UserRepository();
      bool isLogin = await userRepository.loginUser(user);

      _navigateToScreen(isLogin);
    } catch (e) {
      MotionToast.error(
        description: Text("Error: ${e.toString()}"),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double myHeight = MediaQuery.of(context).size.height;
    final double myWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Center(
                child: AnimationWidget(
                  axis: Axis.vertical,
                  curve: Curves.easeOutExpo,
                  offset: 100,
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    "🌿 Bagaicha Florashop 🌹",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: [
                            Colors.green.shade800,
                            Colors.greenAccent,
                          ],
                        ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Login to continue",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7F8C8D),
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                key: const ValueKey('txtEmail'),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                key: const ValueKey('txtPassword'),
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignOut()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                key: const ValueKey('btnLogin'),
                onPressed: () {
                  final user = User(
                    email: emailController.text.trim(),
                    password: passwordController.text,
                  );
                  _loginUser(user);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  minimumSize: Size(myWidth, myHeight * 0.065),
                ),
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignOut()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
