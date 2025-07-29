import 'package:cybershop/repository/userRepository.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  bool showOldPass = false;
  bool showNewPass = false;
  bool showConfirmPass = false;

  void _changePassword() async {
    if (newPassword.text != confirmPassword.text) {
      MotionToast.warning(
        description: const Text("New password and confirm password must match"),
      ).show(context);
      return;
    }

    try {
      UserRepository userRepository = UserRepository();

      bool isChanged = await userRepository.changePassword(
        oldPassword.text,
        newPassword.text,
        confirmPassword.text,
      );

      if (isChanged) {
        MotionToast.success(
          description: const Text("Password changed successfully!"),
        ).show(context);
        oldPassword.clear();
        newPassword.clear();
        confirmPassword.clear();
      } else {
        MotionToast.error(
          description: const Text("Password not changed. Please try again."),
        ).show(context);
      }
    } catch (e) {
      MotionToast.error(
        description: Text("Error: ${e.toString()}"),
      ).show(context);
    }
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool visible,
    required Function() toggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: !visible,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(visible ? Icons.visibility : Icons.visibility_off),
          onPressed: toggleVisibility,
        ),
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF000000),
              const Color(0xFF2C2C2C),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Update Your Password",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A00E0),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildPasswordField(
                      controller: oldPassword,
                      hint: 'Old Password',
                      visible: showOldPass,
                      toggleVisibility: () {
                        setState(() {
                          showOldPass = !showOldPass;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildPasswordField(
                      controller: newPassword,
                      hint: 'New Password',
                      visible: showNewPass,
                      toggleVisibility: () {
                        setState(() {
                          showNewPass = !showNewPass;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildPasswordField(
                      controller: confirmPassword,
                      hint: 'Confirm Password',
                      visible: showConfirmPass,
                      toggleVisibility: () {
                        setState(() {
                          showConfirmPass = !showConfirmPass;
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: const Color(0xFF000000),
                      ),
                      onPressed: _changePassword,
                      child: const Text(
                        'Change Password',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
