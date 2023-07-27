import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Text(
            'MUSIC',
            style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(255, 6, 6, 6),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  navigateToHome() async {
    await Future.delayed(
      const Duration(seconds: 3),);
   
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}
