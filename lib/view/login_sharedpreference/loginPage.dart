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
      backgroundColor: Color.fromARGB(255, 1, 28, 50),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Welcome back you've been missed!",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: uname,
                    decoration: const InputDecoration(
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
                      enabledBorder: const OutlineInputBorder(
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
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    preferences = await SharedPreferences.getInstance();
                    String username = uname.text;
                    String password = pass.text;

                    if (username.isNotEmpty && password.isNotEmpty) {
                      preferences.setString('uname', username);
                      preferences.setString('pass', password);
                      preferences.setBool('newuser', false);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductHome()));
                    }
                    uname.text = "";
                    pass.text = "";
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
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
