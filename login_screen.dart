import 'package:firebaseapp/screens/signup_screen.dart';
import 'package:firebaseapp/widgets/button.dart';
import 'package:flutter/material.dart';

import '../services/authentication.dart';
import '../widgets/snackbar.dart';
import '../widgets/text_field.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    String res = await AuthServices().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if(res == "success") {
      setState(() {
        isLoading = true;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const HomeScreen()));
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login", style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 22,
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: height/2.7,
                  child: Image.asset("images/login.png"),
                ),
                TextFieldInput(
                  textEditingController: emailController,
                  hintText: "Enter your email",
                  icon: Icons.email,
                ),
                TextFieldInput(
                  isPass: true,
                  textEditingController: passwordController,
                  hintText: "Enter your password",
                  icon: Icons.lock,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        "Forgot Password?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue
                      ),
                    ),
                  ),
                ),
                MyButton(
                    onTap: loginUser,
                    text: "Log In"
                ),
                SizedBox(
                  height: height/45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an Account?",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: Colors.black
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignupScreen())
                        );
                      },
                      child: const Text(
                          " Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    
                  ],
                )
              ],
            ),
          ),
      ),
    );
  }
}
