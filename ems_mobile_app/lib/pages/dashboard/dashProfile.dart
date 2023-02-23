import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../colours/Colours.dart';
import '../../services/auth_service.dart';


class DashboardProfile extends StatefulWidget {
  const DashboardProfile({Key? key}) : super(key: key);
  @override
  State<DashboardProfile> createState() => _DashboardProfileState();
}

class _DashboardProfileState extends State<DashboardProfile> {
  int hour = DateTime.now().hour;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AuthService>(context).user;
    final String name = user.name;
    final String? designation = user.role;
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        child: Card(
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                colorFilter:
                    ColorFilter.mode(imageFilterColor, BlendMode.color),
                image: AssetImage("assets/images/ptn.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.width / 2,
                        width: MediaQuery.of(context).size.width / 2,
                        child: const Card(
                          elevation: 0,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/emp.jpg"),
                          ),
                        )),
                    Text(
                      ((hour > 5) && (hour < 12))
                          ? "Hi, Good Morning, \n${name}"
                          : ((hour > 12) && (hour < 17))
                              ? "Hi, Good Afternoon, \n${name}"
                              : "Hi, Good Evening, \n${name}",
                      style: GoogleFonts.righteous(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.black54),
                    )
                  ],
                ),
                Container(
                  color: profileColor,
                  width: MediaQuery.of(context).size.width - 20,
                  height: 80.0,
                  child: ListTile(
                    title: Text(
                      name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    subtitle:  Text("$designation"),
                    // subtitle: const Text("UI/UX Designer"),
                    trailing: const Text("UD - 00001"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
