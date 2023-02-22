import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EMSDrawer extends StatefulWidget {
  const EMSDrawer({Key? key}) : super(key: key);

  @override
  State<EMSDrawer> createState() => _EMSDrawerState();
}

class _EMSDrawerState extends State<EMSDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          //Drawer header user name and email
          const UserAccountsDrawerHeader(
            accountName: Text("Testing User"), //todo set user name
            accountEmail: Text("TestUser@email.com"), //todo set user email
            currentAccountPicture: CircleAvatar(
              backgroundImage:
              AssetImage("assets/images/emp.jpg"),
            ),
          ),

          /* Dashboard (This should override) */
          ListTile(
              onTap: () {
                String? currentRoute = ModalRoute.of(context)?.settings.name;
                if (currentRoute != '/Dash') {
                  Navigator.of(context).pushReplacementNamed('/Dash');
                } else {
                  Navigator.of(context).pop();
                }
              },
              leading: const Icon(Icons.dashboard_outlined),
              title: const Text("Dashboard")),

          /* Profile */
          drawerTile(
              context, const Icon(Iconsax.user_edit), "Profile", "Profile"),

          /* Chat */
          drawerTile(context, const Icon(Iconsax.messages), "Chat", "Chat"),

          /* Email */
          drawerTile(context, const Icon(Iconsax.sms), "Email", "Email"),

          /* Staff */
          drawerTile(context, const Icon(Iconsax.people), "Staff", "Staff"),

          /* Salary */
          drawerTile(
              context, const Icon(Iconsax.wallet_money), "Salary", "Dash"),

          /* Leave */
          drawerTile(context, const Icon(Iconsax.document), "Leave", "Dash"),

          /* Setting */
          drawerTile(context, const Icon(Iconsax.setting), "Setting", "Dash"),

          /* LogOut */
          drawerTile(context, const Icon(Iconsax.logout), "LogOut", "Login"),
        ],
      ),
    );
  }

  /* Drawer Tiles create */
  ListTile drawerTile(
      BuildContext context, Icon iconbtn, String name, String navigate) {
    return ListTile(
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
              context, "/$navigate", (route) => true);
        },
        leading: iconbtn,
        title: Text(name));
  }
}
