import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zego_zimkit/services/services.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userId = TextEditingController();
  final username = TextEditingController();
  final List<String> error = ["","niepoprawne dane, sprobuj ponownie","logowanie powinno sie rozpoczac"];
  int err = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              TextFormField(
                controller: userId,
                decoration: const InputDecoration(
                  labelText: "User Id",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              TextFormField(
                controller: username,
                decoration: const InputDecoration(
                  labelText: "User Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
    Future<bool> comboExists(String key, String value) async {
    print("object ${userId.text}");
    print("entered pass: ${username.text}");
    List<Map<String,String>> users = await getUsers();
    bool exists = false;
    for (int i = 0; i < users.length; i++) {
      print(users[i]['name']);

      if (users[i]['name'] == key && users[i]['password'] == value) {
          exists = true;
          break;
      }
    }

    if(exists){

      await ZIMKit().connectUser(id: userId.text, name: username.text);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(username: userId.text)));
      setState(() {
        err = 2;
      });
    }else
    setState(() {
      err = 1;
    });
    return exists;
    }
    comboExists(userId.text, username.text);

                },
                child: const Text("Log in"),
              ),
              Text(error[err])
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, String>>> getUsers() async {
    List<Map<String, String>> userList = [];

    try {
      QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("users").get();
      List<QueryDocumentSnapshot<Map<String,dynamic>>> documents = querySnapshot.docs;

      for (var document in documents) {
        Map<String, dynamic> data = document.data();

        // Przetwarzanie danych i tworzenie mapy
        String name = data['name'];
        String password = data['password'];

        Map<String, String> userMap = {
          'name': name,
          'password': password,
        };

        userList.add(userMap);
      }
    } catch (e) {
      print('Błąd: $e');
    }
    print(userList);
    return userList;
  }
}
