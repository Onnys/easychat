import 'package:easychat/components/roundedbutton.dart';
import 'package:easychat/screens/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easychat/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'Login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email, password;

  final _auth = FirebaseAuth.instance;

  bool spinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: KEdgeInsets,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                    tag: 'fire',
                    child: Image.asset(
                      'images/fire.png',
                      fit: BoxFit.fitHeight,
                      height: 200,
                    )),
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration:
                      KInputDecoration.copyWith(hintText: 'Enter Your Email')),
              SizedBox(
                height: 20,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: KInputDecoration.copyWith(
                      hintText: 'Enter Your Password')),
              RoundedButton(
                onPressed: () async {
                  setState(() {
                    spinner = true;
                  });
                  try {
                    final loggedIn = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (loggedIn != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      spinner = false;
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Loging error, check your password"),
                      ));
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                color: Colors.blue,
                title: 'Login',
              )
            ],
          ),
        ),
      ),
    );
  }
}
