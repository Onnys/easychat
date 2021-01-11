import 'package:easychat/screens/chat.dart';
import 'package:easychat/screens/login.dart';
import 'package:easychat/screens/register.dart';
import 'package:easychat/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistationScreen.id: (context) => RegistationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
