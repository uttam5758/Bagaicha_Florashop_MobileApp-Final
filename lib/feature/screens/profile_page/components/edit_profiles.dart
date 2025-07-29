// import 'package:flutter/material.dart';

// class EditProfiles extends StatefulWidget {
//   const EditProfiles({super.key});

//   @override
//   State<EditProfiles> createState() => _EditProfilesState();
// }

// class _EditProfilesState extends State<EditProfiles> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Setting UI",
//       home: EditProfilePage(),
//     );
//   }
// }

// class EditProfilePage extends StatefulWidget {
//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   bool showPassword = false;
//   @override
//   Widget build(BuildContext context) {
   
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         elevation: 1,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.green,
//           ),
//           onPressed: () {},
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.settings,
//               color: Colors.green,
//             ),
//             onPressed: () {
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (BuildContext context) => SettingsPage()));
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
//         child: GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: ListView(
//             children: [
//               const Text(
//                 "Edit Profile",
//                 style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               Center(
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: 130,
//                       height: 130,
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                               width: 4,
//                               color: Theme.of(context).scaffoldBackgroundColor),
//                           boxShadow: [
//                             BoxShadow(
//                                 spreadRadius: 2,
//                                 blurRadius: 10,
//                                 color: Colors.black.withOpacity(0.1),
//                                 offset: const Offset(0, 10))
//                           ],
//                           shape: BoxShape.circle,
//                           image: const DecorationImage(
//                               fit: BoxFit.cover,
//                               image: NetworkImage(
//                                 "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
//                               ))),
//                     ),
//                     Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: Container(
//                           height: 40,
//                           width: 40,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               width: 4,
//                               color: Theme.of(context).scaffoldBackgroundColor,
//                             ),
//                             color: Colors.green,
//                           ),
//                           child: const Icon(
//                             Icons.edit,
//                             color: Colors.white,
//                           ),
//                         )),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 35,
//               ),
//               buildTextField("Name", "Ful Name", false),
//               buildTextField("Email", "alexd@gmail.com", false),
//               const SizedBox(
//                 height: 35,
//               ),
//               ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 14, 234, 117),
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 40.0, vertical: 10.0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.0),
//                   ),
//                   textStyle: const TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 child: Text('Update Profile'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(
//       String labelText, String placeholder, bool isPasswordTextField) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 35.0),
//       child: TextField(
//         obscureText: isPasswordTextField ? showPassword : false,
//         decoration: InputDecoration(
//             suffixIcon: isPasswordTextField
//                 ? IconButton(
//                     onPressed: () {
//                       setState(() {
//                         showPassword = !showPassword;
//                       });
//                     },
//                     icon: const Icon(
//                       Icons.remove_red_eye,
//                       color: Colors.grey,
//                     ),
//                   )
//                 : null,
//             contentPadding: const EdgeInsets.only(bottom: 3),
//             labelText: labelText,
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             hintText: placeholder,
//             hintStyle: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             )),
//       ),
//     );
//   }
// }
