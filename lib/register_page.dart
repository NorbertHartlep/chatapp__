
import 'package:chatapp/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
   RegisterPage({Key? key, List<Map<String,String>>? users}) : super(key: key);
  @override
  State<RegisterPage> createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
  }

  final username = TextEditingController();
  final pass = TextEditingController();
  final repeatPass = TextEditingController();
  final List<String> communicate = ["","Ktoś zajął już tą nazwę","Takie konto już istnieje, albo nie wpisałeś poprawnie hasła w obu polach", "Dane wprowadzone popranwie, tworze konto"];
  int numb = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: username,
                  decoration: const InputDecoration(
                    labelText: "Enter your username",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: pass,
                  decoration: const InputDecoration(
                    labelText: "Enter your password",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: repeatPass,
                  decoration: const InputDecoration(
                    labelText: "Repeat your password",
                    border: OutlineInputBorder(),
                  ),
                ),
              ElevatedButton(
                onPressed: () {
                Future<bool> comboExists(String key, String value, String passCheck) async {
                  print("object ${username.text}");
                  print("entered pass: ${pass.text}");
                  List<Map<String,String>> users = await getUsers();
 String expected = value;
     bool exists = false;
   bool claimedUsername = false;
                  for (int i = 0; i < users.length; i++) {
                    print(users[i]['name']);
                    if(users[i]['name'] == key){
                      claimedUsername = true;
                      break;
                    }
                    if (users[i]['name'] == key && users[i]['password'] == expected) {
                      exists = true;
                      break;
                    }
                  }
                  if(claimedUsername){
                    setState(() {
                      numb = 1;
                    });
                  }
                  if(!exists && value == passCheck && !claimedUsername){
                    setState(() {
                      numb = 3;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                      createUser(name: key);
                    });
                  }
                  if(exists || value != passCheck){
                    setState(() {
                      numb = 2;
                    });
                  }


                  return exists;
                }
                comboExists(username.text,pass.text, repeatPass.text);
                },
                child: Text("Register"),),
                Text(communicate[numb]),
                SizedBox(height: 80,),
                ElevatedButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                    child: Text("Mam juz konto"))
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future createUser({required String name}) async{

    final docUser = FirebaseFirestore.instance.collection("users").doc(name);
    final user = {
      'name':username.text,
      'password':pass.text
    };

    await docUser.set(user);
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
