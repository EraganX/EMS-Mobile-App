// import 'package:ems_mobile_app/pages/users_page.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../services/auth_service.dart';
// import '../../services/socket.dart';
// import '../../widgets/button_sign.dart';
// import '../../widgets/input.dart';
// import '../../widgets/login_register_button.dart';
// import '../../widgets/logo.dart';
// import '../helpers/show_alert.dart';
//
// import 'ems_Login.dart';
//
// class RegisterPage extends StatelessWidget {
//   static const routeName = 'Register';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//       child: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//               children: [
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Logo(),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 _Form(),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 const LoginRegisterButton(
//                   routeName: LoginScreen.routeName,
//                   label: 'Already have an Account?',
//                   textButton: 'Log In then!',
//                 ),
//                 const Text('Terms and conditions'),
//               ]),
//         ),
//       ),
//     ));
//   }
// }
//
// class _Form extends StatelessWidget {
//   final userController = TextEditingController();
//   final emailController = TextEditingController();
//   final passController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final authService = Provider.of<AuthService>(context);
//     final socketService = Provider.of<SocketService>(context);
//     return Center(
//       child: Container(
//         constraints: const BoxConstraints(minWidth: 180, maxWidth: 600),
//         padding: const EdgeInsets.symmetric(horizontal: 40),
//         child: Column(children: [
//           Input(
//             icon: Icons.perm_identity_outlined,
//             placeholder: 'User',
//             maxLenght: 16,
//             controller: userController,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Input(
//             icon: Icons.email_outlined,
//             placeholder: 'Email',
//             maxLenght: 32,
//             controller: emailController,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Input(
//             icon: Icons.lock_outlined,
//             placeholder: 'Password',
//             maxLenght: 32,
//             controller: passController,
//             hidden: true,
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           SignButton(
//             label: 'Register',
//             press: authService.logeando
//                 ? null
//                 : () async {
//                     final msg = await authService.register(
//                         userController.text.trim(),
//                         emailController.text.trim(),
//                         passController.text);
//                     if (msg == true) {
//                       socketService.connect("noroom");
//                       Navigator.pushReplacementNamed(
//                           context, UsersPage.routeName);
//                     } else
//                       showAlert(context, 'Register', msg);
//                   },
//           ),
//         ]),
//       ),
//     );
//   }
// }