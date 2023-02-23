
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class Profile extends StatefulWidget {
  static const routeName = "ProfileScreen";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
   String fullName = "John Jecob";
   String role = "Developrt";
   String employeeID = "10203040";
   String dob = "1995/12/15";
   String nic = "9571557594v";
   String tpNo = "+94345571571";
   String gitAccount = "SimpleGT";
   String address = "123 Main St., Anytown, USA 12345";
   String skills = "Flutter, Dart, Mobile Development";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).user;
    String fullName = user.name;
    String email = user.email;
    String? git = user.git;
    String? role = user.role;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10,bottom: 10,),
                width: MediaQuery.of(context).size.width/2,
                height: MediaQuery.of(context).size.width/2,
                child: const CircleAvatar(
                  backgroundImage:
                  AssetImage("assets/images/emp.jpg"),
                ),
                ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.height / 3 * 2,
                child: ListView(
                  children: [
                    userDetails("Name",fullName),
                    userDetails("Email",email),
                    userDetails("Role", role!),
                    userDetails("Employee ID", employeeID),
                    userDetails("Address", address),
                    userDetails("Telephone", tpNo),
                    userDetails("Date Of Birth", dob),
                    userDetails("NIC", nic),
                    userDetails("Git Account", git!),
                    userDetails("Skills", skills),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userDetails(String title, String desc) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          height: 60,
          child: ListTile(
            leading: Text(
              "$title\t:",
              style: const TextStyle(fontSize: 12),
            ),
            title: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SelectableText(
                    desc,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ))),
            minLeadingWidth: 100,
            horizontalTitleGap: 0,
          ),
        ),
        const Divider(height: 3,color: Colors.black,),
      ],
    );
  }

}


