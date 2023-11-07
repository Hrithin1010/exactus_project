import 'package:exactus_project/view/login_sharedpreference/signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navdrawer extends StatefulWidget {
  @override
  State<Navdrawer> createState() => _NavdrawerState();
}

class _NavdrawerState extends State<Navdrawer> {
  late SharedPreferences preferences;

  late String username;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString('uname')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(27.0),
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                preferences.setBool('newuser', true);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SignUp()));
              },
              leading: IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
              title: Text(
                "Log out",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              iconColor: Colors.black,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
