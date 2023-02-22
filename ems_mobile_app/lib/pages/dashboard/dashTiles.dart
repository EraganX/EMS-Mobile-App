import 'package:ems_mobile_app/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class DashboardTiles extends StatelessWidget {
  DashboardTiles({Key? key}) : super(key: key);

  Color buttonColor = Color(0xffffffff);
  TextStyle buttonTS = TextStyle(color: Colors.black);

  Widget DashboardButton(
      BuildContext context, String name, Icon btnicon) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          switch(name){
            case "Chat":Navigator.pushReplacementNamed(context, UsersPage.routeName);
            break;
          }
        },
        style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Color(0xffffffff)),
          overlayColor:
              MaterialStateColor.resolveWith((states) => Color(0xb2ff7d35)),
          // shadowColor:
          //     MaterialStateColor.resolveWith((states) => Color(0xffff4040)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            btnicon,
            const SizedBox(
              height: 5,
            ),
            Text(
              name,
              style: buttonTS,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width - 40,
      height: MediaQuery.of(context).size.width - 160,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 3,
        children: [
          DashboardButton(
              context,
              "Chat",
              const Icon(
                Iconsax.messages,
                color: Colors.black,
              )),

          DashboardButton(
              context,
              "Email",
              const Icon(
                Iconsax.sms,
                // Iconsax.directbox_send4,
                color: Colors.black,
              )),
          DashboardButton(
              context,
              "Profile",
              const Icon(
                Iconsax.user_edit,
                color: Colors.black,
              )), //need to create
          DashboardButton(
              context,
              "Staff",
              const Icon(
                Iconsax.people,
                color: Colors.black,
              )),
          DashboardButton(
              context,
              "Salary",
              const Icon(
                Iconsax.wallet_money,
                color: Colors.black,
              )), //need to create
          DashboardButton(
              context,
              "Leave",
              const Icon(
                Iconsax.document,
                color: Colors.black,
              )), //need to create
        ],
      ),
    );
  }
}
