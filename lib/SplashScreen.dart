
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'conveter.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Conveter(),));
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
        body: Center(
          child: Container(height: 300,child: Lottie.asset("Assets/splashscreen.json")),
        ),
    );
  }
}
