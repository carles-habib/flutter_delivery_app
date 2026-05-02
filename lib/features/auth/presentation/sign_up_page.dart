// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'widgets/sign_up_page_body.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingUpPageBody(),
    );
  }
}






// Column(
//         children: [
//           Container(
//             padding: EdgeInsets.only(top: Dimensions.height30 * 2),
//             width: double.maxFinite,
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               // backgroundImage: AssetImage('assets/images/logoo.png'),
//               radius: 50,
//               child: Image(image: AssetImage('assets/images/logoo.png')),
//             ),
//           ),
//           CustomTextField(
//             controller: emailController,
//             icon: Icons.email,
//             hintText: 'Email',
//           ),
//           CustomTextField(
//             controller: passwordController,
//             icon: Icons.password_sharp,
//             hintText: 'Passwoed',
//           ),
//           CustomTextField(
//             controller: nameController,
//             icon: Icons.person,
//             hintText: 'Name',
//           ),
//           // CustomTextField(
//           //   controller: phoneController,
//           //   icon: Icons.phone,
//           //   hintText: 'Phone',
//           // ),
//         ],
//       ),