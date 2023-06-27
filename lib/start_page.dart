import 'package:chatapp/register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 100,),
                Text("Chat App made By Norbert Hartlep & Szymon Miecznikowski",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                ),
                ),
                SizedBox(height: 120,),
                ElevatedButton(onPressed:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                }, child: Text("Kontynuuj do rejestracji"))
              ],
            ),
          ),
      ),
    );
  }
}
