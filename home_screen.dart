import 'package:firebaseapp/screens/login_screen.dart';
import 'package:firebaseapp/services/authentication.dart';
import 'package:firebaseapp/widgets/button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: const Text(
            "Home Screen",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
            ),
          ),
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                "Welcome to Sha-HuB",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black
              ),
            ),
            MyButton(
                onTap: () async {
                  await AuthServices().signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen() ));
                },
                text: "Log Out"
            ),
          ],
        ),
      ),
    );
  }
}
