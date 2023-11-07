import 'package:exactus_project/view/login_sharedpreference/signup.dart';
import 'package:exactus_project/view/product_home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _Login2State();
}

class _Login2State extends State<LoginPage> {
  final uname = TextEditingController();
  final pass = TextEditingController();
  late SharedPreferences preferences;
  late bool newuser;
  bool isPasswordVisible = false;

  @override
  void initState() {
    check_if_user_already_login();
    super.initState();
  }

  void check_if_user_already_login() async {
    preferences = await SharedPreferences.getInstance();

    newuser = preferences.getBool('newuser') ?? true;
    if (newuser == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProductHome()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                ),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Welcome back you've been missed!",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: uname,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Username",
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: pass,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Password",
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          )),
                    ),
                  ),
                ),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () => validateandLogin(),
                    child: Text("Login")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      "Go to signup page",
                      style: TextStyle(
                          color: Colors.black, fontStyle: FontStyle.italic),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateandLogin() async {
    preferences = await SharedPreferences.getInstance()!;
    String storedusername = preferences.getString('uname')!;
    String storedpassword = preferences.getString('pass')!;

    String usename = uname.text;
    String pwd = pass.text;
    preferences.setBool('newuser', false);

    if (storedusername == usename && storedpassword == pwd) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ProductHome()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid username or password")));
    }
  }
}
