import 'package:cybershop/repository/profileRepository.dart';
import 'package:cybershop/response/profileResponse.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileRepository().getprofile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 4.0,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 14, 234, 117),
      ),
      body: Body(),
    );
  }
}
