import 'package:easychat/components/roundedbutton.dart';
import 'package:easychat/constants.dart';
import 'package:easychat/screens/login.dart';
import 'package:easychat/screens/register.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static String id = 'Welcome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: KEdgeInsets,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(tag: 'fire', child: Image.asset('images/fire.png')),
                Text(
                  'EasyChat',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            SizedBox(
              height: 100,
            ),
            RoundedButton(
              title: 'Login',
              color: Colors.blue,
              onPressed: () => Navigator.pushNamed(context, LoginScreen.id),
            ),
            RoundedButton(
              title: 'Register',
              color: Colors.blueAccent[100],
              onPressed: () => Navigator.pushNamed(context, RegistationScreen.id),
            ),
          ],
        ),
      ),
    );
  }
}
