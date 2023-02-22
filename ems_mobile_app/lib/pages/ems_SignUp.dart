import 'package:ems_mobile_app/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as MG;
import 'package:provider/provider.dart';

import '../colours/Colours.dart';
import '../helpers/show_alert.dart';
import '../services/auth_service.dart';
import '../services/socket.dart';

class SignUp extends StatefulWidget {
  static const routeName = 'SignUp';
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: -MediaQuery.of(context).size.width / 4,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(40 / 360),
                  child: Container(
                    color: loginPageColor,
                    width: MediaQuery.of(context).size.width + 100,
                    height: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              //Logo insert
              Positioned(
                top: 40,
                left: 50,
                right: 50,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    shape: BoxShape.circle,
                    // border: Border.all(color: Color(0xFFFF7D35), width: 5),
                    border: Border.all(color: loginPageColor, width: 5),
                  ),
                  margin: const EdgeInsets.only(top: 50, bottom: 20),
                  height: 244,
                  width: 244,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Image.asset(
                        'assets/images/Hasthiya-Logo-R.png',
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 17 * 9,
                    left: 15,
                    right: 15),
                height: MediaQuery.of(context).size.height / 17 * 15,
                padding: const EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        fieldCreator(userController, "UserName", false),
                        fieldCreator(emailController, "Email", false),
                        fieldCreator(passController, "Password", true),

                        const Divider(
                          color: Colors.transparent,
                          height: 30,
                        ),

                        GestureDetector(
                          onTap: authService.logeando
                              ? null
                              : () async {
                            final msg = await authService.register(
                                userController.text.trim(),
                                emailController.text.trim(),
                                passController.text);
                            if (msg == true) {
                              socketService.connect("noroom");
                              Navigator.pushReplacementNamed(context, UsersPage.routeName);
                            } else
                              showAlert(context, 'Register', msg);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 10),
                            decoration: BoxDecoration(
                                color: loginPageColor,
                                borderRadius: BorderRadius.circular(25)),
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white),
                            ),
                          ),
                        ),

                        const Divider(
                          color: Colors.transparent,
                          height: 40,
                        ),

                        //register
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "I am member? ",
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('Login');
                              },
                              child: const Text("Login Now ",
                                  style: TextStyle(color: Colors.lightBlue)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 17 * 7,
                left: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Register",
                      style: GoogleFonts.righteous(
                          fontSize: 45, color: Colors.white),
                      // style: GoogleFonts.righteous(fontSize: 50,color: Color(0xFFFF7D35)),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "Employee Management System", //bebasNeue
                      style: GoogleFonts.rajdhani(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldCreator(
      TextEditingController controller, String fieldName, bool obscureText) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: (fieldName == "Date of Birth")
            ? TextInputType.datetime
            : (fieldName == "Telephone Number")?TextInputType.phone:TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
            label: Text(fieldName),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        validator: (value) {
          if (fieldName == "Password") {
            if (passController.text.length < 8) {
              return 'Please enter a value for $fieldName';
            }
            return null;
          }
          if (fieldName != "Git Account") {
            if ((value!.isEmpty) && fieldName != "Middle Name") {
              return 'Please enter a value for $fieldName';
            }
            return null;
          }
          return null;
        },
      ),
    );
  }
}
