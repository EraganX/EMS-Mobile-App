import 'package:email_validator/email_validator.dart';
import 'package:ems_mobile_app/pages/ems_Dashboard.dart';
import 'package:ems_mobile_app/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../colours/Colours.dart';
import '../helpers/show_alert.dart';
import '../services/auth_service.dart';
import '../services/socket.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'LoginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? email;

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
                    color: Color(0xffffffff),
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
                height: MediaQuery.of(context).size.height / 17 * 8.5,
                padding: const EdgeInsets.only(top: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      //Email or UserId
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25, top: 25),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            label: const Text("Email"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: const Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (!EmailValidator.validate(value!)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          onSaved: (value) => email = value,
                        ),
                      ),

                      //Password
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25, top: 25),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            label: const Text("Password"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: const Icon(Icons.password),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed("/ForgotPW");
                                },
                                child: const Text("Forgot Password?",
                                    style: TextStyle(color: Colors.lightBlue))),
                          ],
                        ),
                      ),

                      const Divider(
                        color: Colors.transparent,
                        height: 30,
                      ),

                      //sign button
                      GestureDetector(
                        onTap: authService.loggin
                            ? null
                            : () async {
                                FocusScope.of(context).unfocus();
                                final loginOK = await authService.login(
                                    emailController.text.trim(),
                                    passwordController.text);
                                if (loginOK) {
                                  //connect socket server
                                  socketService.connect("noroom");
                                  //navigate to users screen
                                  Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
                                } else {
                                  showAlert(context, 'Login Incorrect',
                                      'Check your credentials and try again');
                                }
                              },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 10),
                          decoration: BoxDecoration(
                              color: loginPageColor,
                              borderRadius: BorderRadius.circular(25)),
                          child: const Text(
                            "Login",
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
                            "Not a member? ",
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('SignUp');
                            },
                            child: const Text("Register now ",
                                style: TextStyle(color: Colors.lightBlue)),
                          ),
                        ],
                      )
                    ],
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
                      "Login",
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
}
