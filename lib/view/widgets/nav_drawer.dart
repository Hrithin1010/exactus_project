import 'package:exactus_project/view/login_sharedpreference/loginPage.dart';
import 'package:exactus_project/view/product_home.dart';
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
      username = preferences
          .getString('uname')!; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white, 
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 1, 28, 50),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor:  Colors.white,
                    radius: 30,
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                 const SizedBox(height: 10),
                  Text(
                    '$username',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.black),
              title: const Text(
                'Home',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) => ProductHome())));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.black),
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            InkWell(
              onTap: () {
                preferences.setBool('newuser', true);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: const ListTile(
                leading: Icon(Icons.logout, color: Colors.black),
                title: Text(
                  'Log out',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
