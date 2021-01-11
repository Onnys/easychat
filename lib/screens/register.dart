import 'package:easychat/components/roundedbutton.dart';
import 'package:easychat/screens/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easychat/constants.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistationScreen extends StatefulWidget {
  static String id = 'Registation';

  @override
  _RegistationScreenState createState() => _RegistationScreenState();
}

class _RegistationScreenState extends State<RegistationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showspinner = false;
  String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
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
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: KInputDecoration.copyWith(
                    hintText: 'Enter Your Email',
                  )),
              SizedBox(
                height: 20,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: KInputDecoration.copyWith(
                      hintText: 'Enter Your Password')),
              RoundedButton(
                onPressed: () async {
                  setState(() {
                    showspinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showspinner = false;
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Registation error, try again"),
                      ));
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                color: Colors.blueAccent[100],
                title: 'Register',
              )
            ],
          ),
        ),
      ),
    );
  }
}
