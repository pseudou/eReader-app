import 'package:flutter/material.dart';
import '../../../../features/home/presentation/pages/home_screen.dart';
import '../../../../core/constants/app_constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 2000));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppConstants.invertedIconPath,
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              'LoreBubbl',
              style: TextStyle(
                fontFamily: '.SF Pro Display', // This will use San Francisco on iOS
                fontSize: 34, // Large title size in iOS
                fontWeight: FontWeight.w700, // Bold weight in iOS
                letterSpacing: 0.37, // Slight letter spacing for large titles
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}