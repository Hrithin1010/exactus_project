
import 'package:exactus_project/controller/providerController.dart';
import 'package:exactus_project/view/login_sharedpreference/signup.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => dataProvider(), 
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignUp(),
      ),
    );
  }
}

